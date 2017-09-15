//
//  DTPagerController.swift
//  Pods
//
//  Created by Tung Vo on 15/09/2017.
//
//

import Foundation

/// PagerViewControllerDelegate
@objc public protocol DTPagerControllerDelegate: NSObjectProtocol {
    @objc optional func pagerController(_ pagerController: DTPagerController, didChangeSelectedPageIndex index: Int)
    @objc optional func pagerController(_ pagerController: DTPagerController, willChangeSelectedPageIndex index: Int, fromPageIndex oldIndex: Int)
    @objc optional func pagerController(_ pagerController: DTPagerController, scrollViewdidScroll: UIScrollView)
}


/// PagerViewController
/// Used to create a pager controller of multiple view controllers.
open class DTPagerController: UIViewController, UIScrollViewDelegate {
    
    /// scrollIndicator below the segmented control bar.
    /// Default background color is blue.
    open fileprivate(set) lazy var scrollIndicator: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor.blue
        return bar
    }()
    
    /// Delegate
    open weak var delegate: DTPagerControllerDelegate?
    
    /// Preferred height of segmented control bar.
    /// Default value is 44.
    /// If viewControllers has less than 2 items, actual height is 0.
    open var preferredSegmentedControlHeight: CGFloat = 44 {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    /// Height of segmented control bar
    /// Get only
    open var segmentedControlHeight: CGFloat {
        return viewControllers.count <= 1 ? 0 : preferredSegmentedControlHeight
    }
    
    /// Preferred of scroll indicator.
    /// Default value is 2.
    /// If viewControllers has less than 2 items, actual height is 0.
    open var perferredScrollIndicatorHeight: CGFloat = 2 {
        didSet {
            // Update height and vertical position
            scrollIndicator.bounds.size.height = scrollIndicatorHeight
            scrollIndicator.frame.origin.y = segmentedControlHeight - scrollIndicatorHeight
        }
    }
    
    /// Height of segmented indicator
    /// Get only
    open var scrollIndicatorHeight: CGFloat {
        return viewControllers.count <= 1 ? 0 : perferredScrollIndicatorHeight
    }
    
    var previousPageIndex : Int = 0
    
    /// Automatically handle child view controllers' appearance transitions when switching between tabs
    /// If you don't want viewWillAppear/viewDidAppear/viewWillDisappear/viewDidDisappear of child view
    /// controllers to be called when switching tabs, this should be set to false.
    /// Default value is true
    open var automaticallyHandleAppearanceTransitions: Bool = true
    
    /// View controllers in Pager View Controller
    /// Get only.
    open fileprivate(set) var viewControllers: [UIViewController]!
    
    /// Current index of pager
    /// Setting selectedPageIndex before viewDidLoad is called will not have any effect
    open var selectedPageIndex : Int {
        set {
            // Prevent calling it before viewDidLoad is called
            if pageSegmentedControl == nil {
                return
            }
            
            if newValue != previousPageIndex {
                pageSegmentedControl.selectedSegmentIndex = newValue
                pageSegmentedControl.sendActions(for: UIControlEvents.valueChanged)
            }
        }
        
        get {
            // Prevent calling it before viewDidLoad is called
            if pageSegmentedControl == nil {
                return 0
            }
            
            //pageSegmentedControl.selectedSegmentIndex can sometimes return -1, so return 0 instead
            return pageSegmentedControl.selectedSegmentIndex < 0 ? 0 : pageSegmentedControl.selectedSegmentIndex
        }
    }
    
    /// Normal text color in segmented control bar
    /// Default value is UIColor.lightGray
    public var textColor: UIColor = UIColor.lightGray {
        didSet {
            if viewIfLoaded != nil {
                updateSegmentedNormalTitleTextAttributes()
            }
        }
    }
    
    /// Selected text color in segmented control bar
    /// Default value is UIColor.black
    public var selectedTextColor: UIColor = UIColor.blue {
        didSet {
            if viewIfLoaded != nil {
                updateSegmentedSelectedTitleTextAttributes()
            }
        }
    }
    
    /// Normal text color in segmented control bar
    /// Default value is UIColor.lightGray
    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            if viewIfLoaded != nil {
                updateSegmentedNormalTitleTextAttributes()
            }
        }
    }
    
    /// Selected text color in segmented control bar
    /// Default value is UIColor.black
    public var selectedFont: UIFont = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            if viewIfLoaded != nil {
                updateSegmentedSelectedTitleTextAttributes()
            }
        }
    }
    
    /// Page segmented control
    open var pageSegmentedControl: DTSegmentedControl!
    
    /// Page scroll view
    /// This should not be exposed. Changing behavior of pageScrollView will destroy functionality of DTPagerController
     var pageScrollView : UIScrollView!
    
    /// Initializer with array of view controllers to be displayed in pager.
    /// Title of each view controller will be used to display in each tab of segmented control.
    public init(viewControllers : [UIViewController]) {
        if viewControllers.count == 0 {
            fatalError("viewControllers cannot be empty")
        }
        
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        
        // Observe title of each view controller to update segmented control
        for viewController in viewControllers {
            viewController.addObserver(self, forKeyPath: #keyPath(title), options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        for viewController in viewControllers {
            viewController.removeObserver(self, forKeyPath: #keyPath(title))
        }
    }
    
    override open func loadView() {
        super.loadView()
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = UIRectEdge()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // Setup page scroll view
        setUpPageScrollView()
        
        // Page segmented control
        var titles = [String]()
        
        for (_, viewController) in viewControllers.enumerated() {
            titles.append(viewController.title ?? "")
        }
        setUpSegmentedControl(titles: titles)
        
        
        // Then add subview, we do this later to prevent viewDidLoad of child view controllers to be called before page segment is allocated.
        for (index, viewController) in viewControllers.enumerated() {
            // Add first view controller to controller hierachy
            if index == 0 {
                viewController.willMove(toParentViewController: self)
                addChildViewController(viewController)
            }
            
            pageScrollView.addSubview(viewController.view)
            
            if index == 0 {
                viewController.didMove(toParentViewController: self)
            }
        }
        
        // Scroll indicator
        setUpScrollIndicator()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update segmented control frame
        pageSegmentedControl.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: segmentedControlHeight)
        
        // Update child view controllers' view frame
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - segmentedControlHeight)
        }
        
        // Update scroll indicator's vertical position
        scrollIndicator.frame.origin.y = segmentedControlHeight - scrollIndicatorHeight
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Segmented control action
    func pageSegmentedControlValueChanged() {
        //Call delegate method before changing value
        delegate?.pagerController?(self, willChangeSelectedPageIndex: selectedPageIndex, fromPageIndex: previousPageIndex)
        
        let oldViewController = viewControllers[previousPageIndex]
        let newViewController = viewControllers[selectedPageIndex]
        
        if automaticallyHandleAppearanceTransitions {
            oldViewController.beginAppearanceTransition(false, animated: true)
            newViewController.beginAppearanceTransition(true, animated: true)
        }
        
        // Call these two methods to notify that two view controllers are being removed or added to container view controller (Check Documentation)
        if automaticallyHandleAppearanceTransitions {
            oldViewController.willMove(toParentViewController: nil)
            newViewController.willMove(toParentViewController: newViewController)
        }
        
        addChildViewController(newViewController)
        
        let size = view.bounds.size
        let contentOffset = CGFloat(selectedPageIndex) * size.width
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.pageScrollView.contentOffset = CGPoint(x: contentOffset, y: 0)
            
            // Update status bar
            self.setNeedsStatusBarAppearanceUpdate()
            
        }, completion: { (finished) -> Void in
            //Call these two methods to notify that two view controllers are already removed or added to container view controller (Check Documentation)
            oldViewController.removeFromParentViewController()
            
            if self.automaticallyHandleAppearanceTransitions {
                oldViewController.didMove(toParentViewController: nil)
                newViewController.didMove(toParentViewController: self)
                
                oldViewController.endAppearanceTransition()
                newViewController.endAppearanceTransition()
            }
            
            //Call delegate method after changing value
            self.delegate?.pagerController?(self, didChangeSelectedPageIndex: self.selectedPageIndex)
        })
        
        //Setting up new previousPageIndex for next change
        previousPageIndex = selectedPageIndex
    }
    
    //MARK: UIScrollViewDelegate's method
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Delegate
        delegate?.pagerController?(self, scrollViewdidScroll: scrollView)
        
        // Update bar position
        scrollIndicator.frame.origin.x = scrollView.contentOffset.x/scrollView.contentSize.width * scrollView.frame.size.width
        // When content offset changes, check if it is closer to the next page
        var index: Int = 0
        if scrollView.contentOffset.x == 0 && scrollView.frame.size.width == 0 {
            index = 0
        }
        else {
            index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        }
        
        // Update segmented selected state only
        if pageSegmentedControl.selectedSegmentIndex != index {
            pageSegmentedControl.selectedSegmentIndex = index
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        selectedPageIndex = index
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
            selectedPageIndex = index
        }
    }
    
    // Observer
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let viewController = object as? UIViewController {
            if keyPath == "title" {
                if let index = viewControllers.index(of: viewController) {
                    pageSegmentedControl?.setTitle(viewController.title, forSegmentAt: index)
                }
            }
        }
    }
}

extension DTPagerController {
    func updateSegmentedNormalTitleTextAttributes() {
        pageSegmentedControl.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : textColor], for: .normal)
        pageSegmentedControl.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : textColor.withAlphaComponent(0.5)], for: [.normal, .highlighted])
    }
    
    func updateSegmentedSelectedTitleTextAttributes() {
        pageSegmentedControl.setTitleTextAttributes([NSFontAttributeName : selectedFont, NSForegroundColorAttributeName : selectedTextColor], for: .selected)
        pageSegmentedControl.setTitleTextAttributes([NSFontAttributeName : selectedFont, NSForegroundColorAttributeName : selectedTextColor.withAlphaComponent(0.5)], for: [.selected, .highlighted])
    }
    
    func updateSegmentedTitleTextAttributes() {
        updateSegmentedNormalTitleTextAttributes()
        updateSegmentedSelectedTitleTextAttributes()
    }
    
    func setUpSegmentedControl(titles: [String]) {
        pageSegmentedControl = DTSegmentedControl(items: titles)
        pageSegmentedControl.selectedSegmentIndex = 0
        pageSegmentedControl.clipsToBounds = false
        pageSegmentedControl.layer.masksToBounds = false
        pageSegmentedControl.addTarget(self, action: #selector(pageSegmentedControlValueChanged), for: UIControlEvents.valueChanged)
        selectedPageIndex = previousPageIndex
        view.addSubview(pageSegmentedControl)
        
        updateSegmentedTitleTextAttributes()
    }
    
    func setUpPageScrollView() {
        let size = view.bounds.size
        
        pageScrollView = UIScrollView()
        pageScrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(viewControllers.count), height: 0)
        pageScrollView.delegate = self
        pageScrollView.isPagingEnabled = true
        pageScrollView.scrollsToTop = false
        pageScrollView.alwaysBounceVertical = false
        pageScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        pageScrollView.frame = CGRect(x: 0, y: segmentedControlHeight, width: size.width, height: size.height - segmentedControlHeight)
        
        view.addSubview(pageScrollView)
    }
    
    func setUpScrollIndicator() {
        scrollIndicator.frame.size = CGSize(width: view.bounds.width/CGFloat(viewControllers.count), height: scrollIndicatorHeight)
        scrollIndicator.frame.origin.x = 0
        view.addSubview(scrollIndicator)
    }
}

