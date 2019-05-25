//
//  AppDelegate.swift
//  DTPagerController
//
//  Created by tungvoduc on 09/15/2017.
//  Copyright (c) 2017 tungvoduc. All rights reserved.
//

import UIKit
import DTPagerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // swiftlint:enable line_length
        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController1 = UINavigationController(rootViewController: PagerController())
        let navigationController2 = UINavigationController(rootViewController: CustomPagerController())

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [navigationController1, navigationController2]

        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()

        return true
    }

}
