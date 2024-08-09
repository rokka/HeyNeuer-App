//
//  AppDelegate.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 23.07.2024.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ///
        Singletone.shared.loadApiToken()
        
        
        return true
    }


}

