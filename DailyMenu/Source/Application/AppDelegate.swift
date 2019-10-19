//
//  AppDelegate.swift
//  Daily Menu
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  private(set) var coordinator: AppCoordinator!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    coordinator = AppCoordinator(window)
    
    return coordinator.registerApplication()
  }
  
}

