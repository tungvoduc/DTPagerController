//
//  PagerController.swift
//  DTPagerController
//
//  Created by tungvoduc on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import DTPagerController

class PagerController: DTPagerController {

    init() {
        super.init(viewControllers: [])
        title = "View Controller"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        perferredScrollIndicatorHeight = 4

        let viewController1 = ViewController()
        viewController1.title = "One"
        viewController1.scrollView.backgroundColor = UIColor.green

        let viewController2 = ViewController()
        viewController2.title = "Two"
        viewController2.scrollView.backgroundColor = UIColor.purple

        let viewController3 = ViewController()
        viewController3.title = "Three"
        viewController3.scrollView.backgroundColor = UIColor.red

        viewControllers = [viewController1, viewController2, viewController3]
        scrollIndicator.layer.cornerRadius = scrollIndicator.frame.height/2

        setSelectedPageIndex(1, animated: false)
    }

}
