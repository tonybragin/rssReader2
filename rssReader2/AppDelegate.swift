//
//  AppDelegate.swift
//  rssReader2
//
//  Created by Tony on 10/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = Builder.getFeedViewController()
        presentFirst(viewController: viewController)
        
        return true
    }

    private func presentFirst(viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}

