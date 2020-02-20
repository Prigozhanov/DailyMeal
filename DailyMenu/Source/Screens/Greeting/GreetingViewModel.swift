//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

//MARK: - View
protocol GreetingView: class {
    func showAuthorizationError()
}

//MARK: - ViewModel
protocol GreetingViewModel {
    
    var view: GreetingView? { get set }
    
    var email: String { get set }
    var password: String { get set }
    
    func performLogin(onSuccess: @escaping VoidClosure, onFailure: @escaping VoidClosure)
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
    
    func performLogin(onSuccess: @escaping VoidClosure, onFailure: @escaping VoidClosure) {
        let req = context.networkService.requestFactory.authenticate(userName: email, password: password)
        context.networkService.send(request: req) { [weak self] result, _ in
            guard let strongSelf = self else { return }
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                self?.keychainService.setValueForItem(.email, self?.email ?? "")
                
                if let user = response.member, let _ = response.token {
                    self?.context.userDefaultsService.updateUserDetails(user: user)
                    self?.context.networkService.fetchUserData(onSuccess: { (user) in
                        if strongSelf.context.userDefaultsService.hasAddress {
                            NotificationCenter.default.post(name: .userLoggedIn, object: nil)
                        } else {
                            NotificationCenter.default.post(name: .userInvalidAddress, object: nil)
                        }
                    }, onFailure: {
                        
                    })
                    onSuccess()
                } else {
                    onFailure()
                }
            case let .failure(error):
                onFailure()
                if error == .unauthorized {
                    self?.view?.showAuthorizationError()
                }
            }
        }
    }
    
}


