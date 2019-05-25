//
//  UIViewController.swift
//  DTPagerController
//
//  Created by tungvoduc on 25/02/2018.
//

import Foundation

public extension UIViewController {
    var pagerController: DTPagerController? {
        get {
            var viewController = parent

            while viewController != nil {
                if let containerViewController = viewController as? DTPagerController {
                    return containerViewController
                }
                viewController = viewController?.parent
            }

            return nil
        }
    }
}
