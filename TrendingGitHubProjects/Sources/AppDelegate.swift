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
    let applicationAssemble = ApplicationAssemble()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityIndicatorManager.shared.isEnabled = true

        applicationAssemble.setup()
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: applicationAssemble.container)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }

}

