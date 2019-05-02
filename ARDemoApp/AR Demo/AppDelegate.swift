//
//  AppDelegate.swift
//  AR Demo
//
//  Created by Jan on 01/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator = RootCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator?.begin()
        window?.makeKeyAndVisible()
        
        return true
    }
}
