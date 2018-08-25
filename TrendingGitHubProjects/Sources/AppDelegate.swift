//
//  AppDelegate.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/21/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import SwinjectStoryboard
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let applicationAssembly = ApplicationAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityIndicatorManager.shared.isEnabled = true

        applicationAssembly.setup()
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: applicationAssembly.container)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
        setupNavigatioBarAppearance()
        
        return true
    }

    private func setupNavigatioBarAppearance() {
        let mainTintColor = UIColor(named: "MainTintColor")
        mainTintColor.map {
            UIBarButtonItem.appearance().tintColor = $0
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: $0]
        }
    }

}
