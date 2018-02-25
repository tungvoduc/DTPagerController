//
//  CustomPagerController.swift
//  DTPagerController_Example
//
//  Created by Admin on 25/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import DTPagerController
import HMSegmentedControl

class CustomPagerController: DTPagerController {
    
    init() {
        let viewController1 = ViewController()
        viewController1.title = "VC 1"
        viewController1.scrollView.backgroundColor = UIColor.green
        
        let viewController2 = ViewController()
        viewController2.title = "Very looooong title"
        viewController2.scrollView.backgroundColor = UIColor.purple
        
        let viewController3 = ViewController()
        viewController3.title = "VC 3"
        viewController3.scrollView.backgroundColor = UIColor.red
        
        let pageControl = HMSegmentedControl(sectionTitles: ["VC 1", "Very looooong title", "VC 3"])
        
        super.init(viewControllers: [viewController1, viewController2, viewController3], pageSegmentedControl: pageControl!)
        
        title = "CustomPagerViewController"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func setUpSegmentedControl(titles: [String]) {
        super.setUpSegmentedControl(titles: titles)
        
        perferredScrollIndicatorHeight = 0
    }
}

extension HMSegmentedControl: SegmentedControl {
    public var numberOfSegments: Int {
        return 0
    }
    
    public func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) {
        
    }
    
    public func insertSegment(with image: UIImage?, at segment: Int, animated: Bool) {
        
    }
    
    public func removeSegment(at segment: Int, animated: Bool) {
        
    }
    
    public func removeAllSegments() {
        
    }
    
    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        
    }
    
    public func titleForSegment(at segment: Int) -> String? {
        return nil
    }
    
    public func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState) {
        
    }
    
    public func titleTextAttributes(for state: UIControlState) -> [AnyHashable : Any]? {
        return nil
    }
    
}
