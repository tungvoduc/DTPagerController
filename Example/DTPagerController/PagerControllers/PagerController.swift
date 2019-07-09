//
//  PagerController.swift
//  DTPagerController
//
//  Created by tungvoduc on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import DTPagerController
import UIKit

class PagerController: DTPagerController {
    init() {
        super.init(viewControllers: [])
        title = "PagerController"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        perferredScrollIndicatorHeight = 4

        let viewController1 = CityListViewController(cellType: .light)
        viewController1.title = "One"

        let viewController2 = CityListViewController(cellType: .dark)
        viewController2.title = "Two"

        let viewController3 = CityListViewController(cellType: .light)
        viewController3.title = "Three"

        viewControllers = [viewController1, viewController2, viewController3]
        scrollIndicator.backgroundColor = UIColor.appDefault
        scrollIndicator.layer.cornerRadius = scrollIndicator.frame.height / 2

        setSelectedPageIndex(1, animated: false)

        pageSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.appDefault], for: .selected)
        pageSegmentedControl.backgroundColor = .white
        pageSegmentedControl.layer.masksToBounds = false
        pageSegmentedControl.layer.shadowColor = UIColor.lightGray.cgColor
        pageSegmentedControl.layer.shadowOffset = CGSize(width: 0, height: 1)
        pageSegmentedControl.layer.shadowRadius = 1
        pageSegmentedControl.layer.shadowOpacity = 0.5
    }

}
