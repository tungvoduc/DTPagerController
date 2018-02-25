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
        viewController1.scrollView.backgroundColor = UIColor.green
        
        let viewController2 = ViewController()
        viewController2.scrollView.backgroundColor = UIColor.purple
        
        let viewController3 = ViewController()
        viewController3.scrollView.backgroundColor = UIColor.red
        
        let segmentedControl = HMSegmentedControl(sectionTitles: ["View controller 1", "A very loooooooooong title", "View controller 3"])
        
        super.init(viewControllers: [viewController1, viewController2, viewController3], pageSegmentedControl: segmentedControl!)
        title = "CustomPagerController"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUpSegmentedControl(viewControllers: [UIViewController]) {
        super.setUpSegmentedControl(viewControllers: viewControllers)
        
        perferredScrollIndicatorHeight = 0
        let segmentedControl = pageSegmentedControl as! HMSegmentedControl
        segmentedControl.selectionIndicatorColor = UIColor.blue
    }
    
    override func setUpAppearanceForSegmentedItem(at index: Int) {
        // Does not do anything since custom page control does not support title/image update
    }
    
}

extension HMSegmentedControl: SegmentedControl {
    
    public var numberOfSegments: Int {
        // Custom page control does not support
        return 0
    }
    
    public func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) {
        // Custom page control does not support
    }
    
    public func insertSegment(with image: UIImage?, at segment: Int, animated: Bool) {
        // Custom page control does not support
    }
    
    public func removeSegment(at segment: Int, animated: Bool) {
        // Custom page control does not support
    }
    
    public func removeAllSegments() {
        // Custom page control does not support
    }
    
    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }
    
    public func titleForSegment(at segment: Int) -> String? {
        // Custom page control does not support
        return nil
    }
    
    public func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState) {
        if state == UIControlState.normal {
            titleTextAttributes = attributes
        }
        else if state == UIControlState.selected {
            selectedTitleTextAttributes = attributes
        }
    }
    
    public func titleTextAttributes(for state: UIControlState) -> [AnyHashable : Any]? {
        if state == UIControlState.normal {
            return titleTextAttributes
        }
        else if state == UIControlState.selected {
            return selectedTitleTextAttributes
        }
        
        return nil
    }
    
}
