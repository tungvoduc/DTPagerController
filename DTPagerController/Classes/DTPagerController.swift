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
    @objc open weak var delegate: DTPagerControllerDelegate?
    
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
    open var viewControllers: [UIViewController] {
        didSet {
            // Remove observers
            unobserveTitleFrom(viewControllers: oldValue)
            
            // Add observers
            observeTitleFrom(viewControllers: viewControllers)
            
            removeChildViewControllers(oldValue)
            setUpViewControllers()
        }
    }
    
    /// Current index of pager
    /// Setting selectedPageIndex before viewDidLoad is called will not have any effect
    open var selectedPageIndex : Int {
        set {
            if newValue != previousPageIndex {
                pageSegmentedControl.selectedSegmentIndex = newValue
                pageSegmentedControl.sendActions(for: UIControlEvents.valueChanged)
            }
        }
        
        get {//pageSegmentedControl.selectedSegmentIndex can sometimes return -1, so return 0 instead
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
    open lazy var pageSegmentedControl: DTSegmentedControl = {
        let pageControl = DTSegmentedControl(items: [])
        pageControl.clipsToBounds = false
        pageControl.layer.masksToBounds = false
        return pageControl
    }()
    
    /// Page scroll view
    /// This should not be exposed. Changing behavior of pageScrollView will destroy functionality of DTPagerController
    public private(set) lazy var pageScrollView : UIScrollView = {
        let pageScrollView = UIScrollView()
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.isPagingEnabled = true
        pageScrollView.scrollsToTop = false
        return pageScrollView
    }()
    
    /// Initializer with array of view controllers to be displayed in pager.
    /// Title of each view controller will be used to display in each tab of segmented control.
    public init(viewControllers controllers: [UIViewController]) {
        viewControllers = controllers
        
        super.init(nibName: nil, bundle: nil)
        
        // Observe title of each view controller to update segmented control
        observeTitleFrom(viewControllers: viewControllers)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        viewControllers = []
        super.init(coder: aDecoder)
    }
    
    deinit {
        unobserveTitleFrom(viewControllers: viewControllers)
        unobserveScrollViewDelegate(pageScrollView)
    }
    
    override open func loadView() {
        super.loadView()
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = UIRectEdge()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        pageScrollView.delegate = self
        observeScrollViewDelegate(pageScrollView)
        
        setUpViewControllers()
        
        updateSegmentedTitleTextAttributes()
        
        // Add subviews
        view.addSubview(pageScrollView)
        view.addSubview(pageSegmentedControl)
        view.addSubview(scrollIndicator)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update segmented control frame
        pageSegmentedControl.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: segmentedControlHeight)
        
        // Update child view controllers' view frame
        for (index, viewController) in viewControllers.enumerated() {
            viewController.viewIfLoaded?.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - segmentedControlHeight)
        }
        
        // Scroll view
        setUpPageScrollView()
        
        // Update scroll indicator's vertical position
        setUpScrollIndicator()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Segmented control action
    @objc func pageSegmentedControlValueChanged() {
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
            addChildViewController(newViewController)
        }
        
        let size = view.bounds.size
        let contentOffset = CGFloat(selectedPageIndex) * size.width
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.pageScrollView.contentOffset = CGPoint(x: contentOffset, y: 0)
            
            // Update status bar
            self.setNeedsStatusBarAppearanceUpdate()
            
        }, completion: { (finished) -> Void in
            // Call these two methods to notify that two view controllers are already removed or added to container view controller (Check Documentation)
            if self.automaticallyHandleAppearanceTransitions {
                oldViewController.removeFromParentViewController()
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
    
    // Remove all current child view controllers
    private func removeChildViewControllers(_ childViewControllers: [UIViewController]) {
        // Remove each child view controller and its view from parent view controller and its view hierachy
        for viewController in childViewControllers {
            if automaticallyHandleAppearanceTransitions {
                viewController.beginAppearanceTransition(false, animated: false)
            }
            
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
            
            if automaticallyHandleAppearanceTransitions {
                viewController.endAppearanceTransition()
            }
        }
    }
    
    // Setup new child view controllers
    // Called in viewDidLoad or each time a new array of viewControllers is set
    private func setUpViewControllers() {
        // Setup page scroll view
        setUpPageScrollView()
        
        // Page segmented control
        var titles = [String]()
        
        for (_, viewController) in viewControllers.enumerated() {
            titles.append(viewController.title ?? "")
        }
        
        setUpSegmentedControl(titles: titles)
        
        let indexes = self.visiblePageIndexes()
        
        // Then add subview, we do this later to prevent viewDidLoad of child view controllers to be called before page segment is allocated.
        for (index, viewController) in viewControllers.enumerated() {
            // Add view controller's view if it must be visible in scroll view
            if let _ = indexes.index(of: index) {
                // Add to call viewDidLoad if needed
                viewController.view.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - segmentedControlHeight)
                pageScrollView.addSubview(viewController.view)
                
                // This will call viewWillAppear
                addChildViewController(viewController)
                
                // This will call viewDidAppear
                viewController.didMove(toParentViewController: self)
            }
        }
        
        // Scroll indicator
        setUpScrollIndicator()
    }
    
    //MARK: UIScrollViewDelegate's method
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable animation
        UIView.setAnimationsEnabled(false)
        
        // Delegate
        delegate?.pagerController?(self, scrollViewdidScroll: scrollView)
        
        // Add child view controller's view if needed
        let indexes = self.visiblePageIndexes()
        
        for index in indexes {
            let viewController = viewControllers[index]
            viewController.view.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - segmentedControlHeight)
            pageScrollView.addSubview(viewController.view)
        }
        
        // Enable animation back
        UIView.setAnimationsEnabled(true)
        
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
            if keyPath == #keyPath(UIViewController.title) {
                if let index = viewControllers.index(of: viewController) {
                    pageSegmentedControl.setTitle(viewController.title, forSegmentAt: index)
                }
            }
        }
        else if let scrollView = object as? UIScrollView {
            if scrollView == pageScrollView {
                if keyPath == #keyPath(UIScrollView.delegate) {
                    fatalError("Cannot set delegate of pageScrollView to different object than DTPagerController that owns it.")
                }
            }
        }
    }
    
    // Return page indexes that are visible
    private func visiblePageIndexes() -> [Int] {
        guard pageScrollView.bounds.width > 0, viewControllers.count > 0 else {
            return []
        }
        
        let offsetRatio = pageScrollView.contentOffset.x / pageScrollView.bounds.width
        
        if offsetRatio <= 0 {
            return [0]
        }
        else if offsetRatio >= CGFloat(viewControllers.count - 1) {
            return [viewControllers.count - 1]
        }
        
        let floorValue = Int(floor(offsetRatio))
        let ceilingValue = Int(ceil(offsetRatio))
        
        if floorValue == ceilingValue {
            return [floorValue]
        }
        
        return [floorValue, ceilingValue]
    }
}

extension DTPagerController {
    func updateSegmentedNormalTitleTextAttributes() {
        pageSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : font, NSAttributedStringKey.foregroundColor : textColor], for: .normal)
        pageSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : font, NSAttributedStringKey.foregroundColor : textColor.withAlphaComponent(0.5)], for: [.normal, .highlighted])
    }
    
    func updateSegmentedSelectedTitleTextAttributes() {
        pageSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : selectedFont, NSAttributedStringKey.foregroundColor : selectedTextColor], for: .selected)
        pageSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : selectedFont, NSAttributedStringKey.foregroundColor : selectedTextColor.withAlphaComponent(0.5)], for: [.selected, .highlighted])
    }
    
    func updateSegmentedTitleTextAttributes() {
        updateSegmentedNormalTitleTextAttributes()
        updateSegmentedSelectedTitleTextAttributes()
    }
    
    func setUpSegmentedControl(titles: [String]) {
        pageSegmentedControl.removeAllSegments()
        
        for (index, title) in titles.enumerated() {
            pageSegmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        pageSegmentedControl.selectedSegmentIndex = 0
        pageSegmentedControl.addTarget(self, action: #selector(pageSegmentedControlValueChanged), for: UIControlEvents.valueChanged)
        selectedPageIndex = previousPageIndex
    }
    
    func setUpPageScrollView() {
        let size = view.bounds.size
        
        // Updating pageScrollView's frame or contentSize will automatically trigger scrollViewDidScroll(_: UIScrollView) and update selectedPageIndex
        // We need to save the value of selectedPageIndex and update pageScrollView's horizontal content offset correctly.
        let index = selectedPageIndex
        pageScrollView.frame = CGRect(x: 0, y: segmentedControlHeight, width: size.width, height: size.height - segmentedControlHeight)
        pageScrollView.contentSize = CGSize(width: pageScrollView.frame.width * CGFloat(viewControllers.count), height: 0)
        pageScrollView.contentOffset.x = pageScrollView.frame.width * CGFloat(index)
    }
    
    func setUpScrollIndicator() {
        if viewControllers.count > 0 {
            scrollIndicator.frame.size = CGSize(width: view.bounds.width/CGFloat(viewControllers.count), height: scrollIndicatorHeight)
        }
        
        scrollIndicator.frame.origin.y = segmentedControlHeight - scrollIndicatorHeight
        scrollIndicator.frame.origin.x = scrollIndicator.frame.width * CGFloat(selectedPageIndex)
    }
}

//MARK: Observers
extension DTPagerController {
    func observeTitleFrom(viewControllers: [UIViewController]) {
        for viewController in viewControllers {
            viewController.addObserver(self, forKeyPath: #keyPath(title), options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    func unobserveTitleFrom(viewControllers: [UIViewController]) {
        for viewController in viewControllers {
            viewController.removeObserver(self, forKeyPath: #keyPath(title))
        }
    }
    
    // Observe delegate value changed to disallow that
    // Called in viewDidLoad
    func observeScrollViewDelegate(_ scrollView: UIScrollView) {
        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.delegate), options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    
    func unobserveScrollViewDelegate(_ scrollView: UIScrollView) {
        // observeScrollViewDelegate is called in viewDidLoad
        // check if viewDidLoad has been called before remove observer
        if viewIfLoaded != nil {
            scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.delegate), context: nil)
        }
    }
}
