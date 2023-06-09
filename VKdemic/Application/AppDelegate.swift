//
//  AppDelegate.swift
//  VKdemic
//
//  Created by Djinsolobzik on 04.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

