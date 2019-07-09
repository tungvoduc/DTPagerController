//
//  AppDelegate.swift
//  DTPagerController
//
//  Created by tungvoduc on 09/15/2017.
//  Copyright (c) 2017 tungvoduc. All rights reserved.
//

import DTPagerController
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // swiftlint:enable line_length
        window = UIWindow(frame: UIScreen.main.bounds)

        let color = UIColor.appDefault
        let navigationController1 = UINavigationController(rootViewController: PagerController())
        let navigationController2 = UINavigationController(rootViewController: CustomPagerController())

        [navigationController1, navigationController2].forEach {
            $0.navigationBar.barTintColor = UIColor(red: 1, green: 0.3529, blue: 0.3176, alpha: 1)
            $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [navigationController1, navigationController2]
        tabbarController.tabBar.barTintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: color], for: .selected)

        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()

        return true
    }
}

// MARK: - UIColor extension
extension UIColor {
    static var appDefault: UIColor {
        return UIColor(red: 0.2, green: 0.4, blue: 1, alpha: 1)
    }
}
