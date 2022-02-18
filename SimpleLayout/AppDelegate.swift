//
//  AppDelegate.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 18.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [
            UINavigationController(rootViewController: ItemsViewController()),
            UINavigationController(rootViewController: ProfileViewController())
        ]
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
