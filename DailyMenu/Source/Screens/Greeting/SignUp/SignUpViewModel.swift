//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking
import Services

// MARK: - View
protocol SignUpView: class {
    func onSuccessAction()
    func onErrorAction(message: String?)
}

// MARK: - ViewModel
protocol SignUpViewModel {
    
    var view: SignUpView? { get set }
    
    var email: String { get set }
    var password: String { get set }
    var phone: String { get set }
    
    func signUp()
    
}

// MARK: - Implementation
final class SignUpViewModelImplementation: SignUpViewModel {
    
    weak var view: SignUpView?
    
    var email: String = ""
    
    var password: String = ""
    
    var phone: String = ""
    
    private var isValid: Bool {
        guard Formatter.Email.isValid(string: email) else {
            view?.onErrorAction(message: "Invalid email format")
            return false
        }
        guard Formatter.PhoneNumber.isValid(string: phone) else {
            view?.onErrorAction(message: "Invalid phone format")
            return false
        }
        guard password.count >= 6 else {
            view?.onErrorAction(message: "Password minimum length should be at least 6")
            return false
        }
        return true
    }
    
    private let context: AppContext
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    init() {
        context = AppDelegate.shared.context
        networkService = context.networkService
        userDefaultsService = context.userDefaultsService
    }
    
    func signUp() {
        guard isValid else {
            return
        }
        let req = networkService.requestFactory.signup(email: email, password: password, phone: phone)
        
        networkService.send(request: req) { [weak self] (result, _) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.userDefaultsService.setValueForKey(key: .email, value: response.model?.email)
                self.userDefaultsService.setValueForKey(key: .phone, value: response.model?.phone)
                self.view?.onSuccessAction()
            case let .failure(error):
                logDebug(message: error.localizedDescription)
                if error == .unprocessable {
                    self.view?.onErrorAction(message: "Account with email \(self.email) is already exists")
                    return
                }
                self.view?.onErrorAction(message: "Error, please try again")
            }
        }
    }
    
}
