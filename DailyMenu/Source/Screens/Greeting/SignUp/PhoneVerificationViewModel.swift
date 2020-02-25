//
//  Created by Vladimir on 2/7/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Networking
import Foundation

protocol PhoneVerificationView: AnyObject {
    func onSuccessAction()
    func onErrorAction()
}

protocol PhoneVerificationViewModel {
    
    var view: PhoneVerificationView? { get set }
    
    var phone: String { get set }
    
    var phoneVerified: Bool { get set }
    
    func sendVerifyingCode(validationCode: String)
    func sendPushGeneration()
    
}

class PhoneVerificationViewModelImplementation: PhoneVerificationViewModel {
    
    weak var view: PhoneVerificationView?
    
    var phone: String
    
    var phoneVerified: Bool = false
    
    let context: AppContext
    
    init(phone: String) {
        context = AppDelegate.shared.context
        self.phone = phone
        phoneVerified = false
    }
    
    func sendVerifyingCode(validationCode: String) {
        let req = context.networkService.requestFactory.verifyToken(validationCode: validationCode)
        
        context.networkService.send(request: req) { [weak self] result, _ in
            switch result {
            case let .success(response):
                if let user = response.member, let jwtToken = response.jwtToken {
                    self?.context.userDefaultsService.updateUserDetails(user: user)
                    self?.context.keychainSevice.setValueForItem(.JWTToken, jwtToken)
                }
                self?.phoneVerified = true
                self?.view?.onSuccessAction()
            case .failure:
                self?.view?.onErrorAction()
            }
        }
    }
    
    
    func sendPushGeneration() {
        let req = context.networkService.requestFactory.generateToken(phone: phone)
        context.networkService.send(request: req) { [weak self] result, _ in
            LoadingIndicator.hide()
            switch result {
            case .success:
                self?.view?.onSuccessAction()
            case .failure:
                self?.view?.onErrorAction()
            }
        }
    }
    
}
