//
//  AppDelegate.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // - Mentioned in other areas of the code, but here is where our Router or Coordinator would
        // - start.  Using a factory could work as well.
        
        let container = DependencyContainer()        
        let navigationController = UINavigationController(rootViewController: HomeViewController(dependencies: container))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        // Override point for customization after application launch.
        return true
    }
}

