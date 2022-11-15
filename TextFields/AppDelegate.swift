//
//  AppDelegate.swift
//  TextFields
//
//  Created by Beavean on 24.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let navigation = UINavigationController(rootViewController: AllTextFieldsViewController())
        navigation.modalPresentationStyle = .fullScreen
        window?.rootViewController = navigation
        return true
    }
}
