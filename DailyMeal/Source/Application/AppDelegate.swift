//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

protocol AppDelegateProtocol {
    var coordinator: AppCoordinator! { get }
    
    var context: AppContext! { get } // TODO make shared instance
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppDelegateProtocol {
    
    static let shared: AppDelegateProtocol = UIApplication.shared.delegate as! AppDelegateProtocol
    
    private(set) var coordinator: AppCoordinator!
    
    private(set) var context: AppContext!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        context = AppContext()
        
        coordinator = AppCoordinator(window, keychainService: context.keychainSevice, userDefaultsService: context.userDefaultsService, networkService: context.networkService)
        
        return coordinator.registerApplication()
    }
    
}
