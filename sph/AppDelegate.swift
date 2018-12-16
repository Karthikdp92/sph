//
//  AppDelegate.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Setup realm database
        CacheManager.setupRealm()
        return true
    }
}

