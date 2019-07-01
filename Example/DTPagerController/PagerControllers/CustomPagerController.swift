//
//  CustomPagerController.swift
//  DTPagerController_Example
//
//  Created by tungvoduc on 25/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import DTPagerController
import HMSegmentedControl
import UIKit

class CustomPagerController: DTPagerController {
    init() {
        let viewController1 = CityListViewController(cellType: .light)
        viewController1.title = "One"

        let viewController2 = CityListViewController(cellType: .dark)
        viewController2.title = "Two"

        let viewController3 = CityListViewController(cellType: .light)
        viewController3.title = "Three"

        // swiftlint:disable line_length
        guard let segmentedControl = HMSegmentedControl(sectionTitles: ["Cities", "So many cities", "Many many many .......... cities"]) else {
            fatalError("HMSegmentedControl cannot be created")
        }

        segmentedControl.segmentWidthStyle = .dynamic
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        super.init(viewControllers: [viewController1, viewController2, viewController3], pageSegmentedControl: segmentedControl)
        // swiftlint:enable line_length

        title = "CustomPagerController"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUpSegmentedControl(viewControllers: [UIViewController]) {
        super.setUpSegmentedControl(viewControllers: viewControllers)

        perferredScrollIndicatorHeight = 0

        if let segmentedControl = pageSegmentedControl as? HMSegmentedControl {
            segmentedControl.selectionIndicatorColor = UIColor.blue
        }
    }

    override func updateAppearanceForSegmentedItem(at index: Int) {
        // Does not do anything since custom page control does not support title/image update
    }
}

extension HMSegmentedControl: DTSegmentedControlProtocol {
    public func setImage(_ image: UIImage?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }

    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }

    public func setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if state == UIControl.State.normal {
            titleTextAttributes = attributes
        } else if state == UIControl.State.selected {
            selectedTitleTextAttributes = attributes
        }
    }
}
