//
//  AppCoordinator.swift
//  DailyMenu
//

import UIKit

class AppCoordinator {
  
  private let window: UIWindow
  
  init(_ window: UIWindow) {
    self.window = window
  }
  
  func registerApplication() -> Bool {
    window.rootViewController = makeRootViewController()
    window.makeKeyAndVisible()
    
    showGreeting()
    
    return true
  }
  
}

private extension AppCoordinator {
  
  func makeRootViewController() -> UIViewController {
    let tabbar = UITabBarController()
    tabbar.viewControllers = [
      cartTab,
      exploreTab,
      settingsTab
    ]
    return tabbar
  }
  
  var exploreTab: UINavigationController {
    let vm = RestaurantsViewModelImplementation()
    let vc = RestaurantsViewController(viewModel: vm)
    vc.tabBarItem.image = Images.tabExploreInactive.image
    vc.tabBarItem.title = "Explore"
    return UINavigationController(rootViewController: vc)
  }
  
  var settingsTab: UINavigationController {
    let vm = SettingsViewModelImplementation()
    let vc = SettingsViewController(viewModel: vm)
    vc.tabBarItem.image = Images.tabSettingsInactive.image
    vc.tabBarItem.title = "Settings"
    return UINavigationController(rootViewController: vc)
  }
  
  var cartTab: UINavigationController {
    let vm = CartViewModelImplementation()
    let vc = CartViewController(viewModel: vm)
    vc.tabBarItem.image = Images.tabCartInactive.image
    vc.tabBarItem.title = "Cart"
    return UINavigationController(rootViewController: vc)
  }
  
  func showGreeting() {
    let vm = GreetingViewModelImplementation()
    let vc = GreetingViewController(viewModel: vm)
    window.rootViewController?.show(vc, sender: nil)
  }
  
}
