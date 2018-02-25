//
//  UIViewController.swift
//  DTPagerController
//
//  Created by Admin on 25/02/2018.
//

import Foundation

public extension UIViewController {
    var pagerController : DTPagerController? {
        get {
            var viewController : UIViewController?
            viewController = self
            
            while viewController != nil {
                if let containerViewController = viewController?.parent as? DTPagerController {
                    return containerViewController
                }
                else {
                    viewController = viewController?.parent
                }
            }
            
            return nil
        }
    }
}
