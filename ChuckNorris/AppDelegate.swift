//
//  AppDelegate.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationbar()
        setupInitialViewController()
        return true
    }
    
    /// Sets the start ViewController
    private func setupInitialViewController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window?.makeKeyAndVisible()
    }
    
    /// Configures the deafault navigation bar state
    private func setupNavigationbar(){
        UINavigationBar.appearance().tintColor    = .white
        UINavigationBar.appearance().barTintColor = .appColor(.mainColour)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
    }
}

