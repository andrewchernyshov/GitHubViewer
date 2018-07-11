//
//  AppDelegate.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/10/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var presenter: UINavigationController!
    let networkManager = NetworkManager()
    private var appCoordinator: (Coordinator & NewFlowHandler)!
    lazy private var networkService = NetworkManager()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        presenter = UINavigationController()
        window?.rootViewController = presenter
        appCoordinator = AppCoordinator(presenter: presenter, networkManager: networkManager)
        appCoordinator.newFlowRequest = { controller in
            if let window = self.window {
                UIView.transition(with: window, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                    window.rootViewController = controller
                }, completion: nil)
            }
        }
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }


}

