//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

//MARK: - View
protocol GreetingView: class {
    func closeView()
}

//MARK: - ViewModel
protocol GreetingViewModel {
    
    var view: GreetingView? { get set }
    
    var email: String { get set }
    var password: String { get set }
    
    func performLogin()
}

//MARK: - Implementation
final class GreetingViewModelImplementation: GreetingViewModel {
    
    private let context: AppContext
    private let keychainService: KeychainService
    
    weak var view: GreetingView?
    
    var email: String
    var password: String = ""
    
    init() {
        context = AppDelegate.shared.context
        keychainService = context.keychainSevice
        email = keychainService.getValueForItem(.email) ?? ""
    }
    
    func performLogin() {
        let req = Requests.authenticate(userName: email, password: password)
        LoadingIndicator.show()
        context.networkService.send(request: req) { [weak self] result in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                self?.keychainService.setValueForItem(.email, self?.email ?? "")
                if let user = response.member {
                    NotificationCenter.default.post(name: .userLoggedIn, object: user)
                    self?.context.userDefaultsService.setValueForKey(key: .name, value: user.name)
                    self?.context.userDefaultsService.setValueForKey(key: .lastname, value: user.lastname)
                    self?.context.userDefaultsService.setValueForKey(key: .email, value: user.email)
                    self?.context.userDefaultsService.setValueForKey(key: .phone, value: user.phone)
                    self?.view?.closeView()
                }
            case let .failure(error):
                print(error) // TODO
            }
        }
    }
    
}


