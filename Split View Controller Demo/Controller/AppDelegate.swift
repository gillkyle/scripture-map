//
//  AppDelegate.swift
//  Split View Controller Demo
//
//  Created by Steve Liddle on 11/1/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    
    private struct Storyboard {
        static let MainStoryboardName = "Main"
        static let MapVCIdentifier = "DetailVC"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let splitVC = window!.rootViewController as? UISplitViewController {
            splitVC.delegate = self
        }
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        MapConfiguration.sharedConfig.hasMapButton = true
        MapConfiguration.sharedConfig.selected = false
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        if let navVC = primaryViewController as? UINavigationController {
            for controller in navVC.viewControllers {
                if controller.restorationIdentifier == Storyboard.MapVCIdentifier {
                    return controller
                }
            }
        }
        MapConfiguration.sharedConfig.hasMapButton = false
        let storyboard = UIStoryboard(name: Storyboard.MainStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.MapVCIdentifier)
    }
}

