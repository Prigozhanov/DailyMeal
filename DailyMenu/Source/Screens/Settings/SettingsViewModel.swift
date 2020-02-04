//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol SettingsView: class {
    
}

//MARK: - ViewModel
protocol SettingsViewModel {
    
    var view: SettingsView? { get set }
    
    var userName: String? { get set }
    
}

//MARK: - Implementation
final class SettingsViewModelImplementation: SettingsViewModel {
    
    weak var view: SettingsView?
    
    let context: AppContext
    
    var userName: String?
    
    init() {
        context = AppDelegate.shared.context
        userName = context.userDefaultsService.getValueForKey(key: .name)
    }
    
    
    
}


