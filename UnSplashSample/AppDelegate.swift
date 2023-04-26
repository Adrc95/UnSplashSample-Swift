//
//  AppDelegate.swift
//  UnSplashSample
//
//  Created by Adrian on 17/4/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           window = UIWindow(frame: UIScreen.main.bounds)
           installRootViewControllerIntoWindow(window)
           window?.makeKeyAndVisible()
           return true
    }

    private func installRootViewControllerIntoWindow(_ window: UIWindow?) {
           let viewController = ServiceLocator().providerRootViewController()
           window?.rootViewController = viewController
    }
}
