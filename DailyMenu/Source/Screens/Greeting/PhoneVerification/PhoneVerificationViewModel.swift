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
    
    var phoneNumber: String { get set }
    
    var phoneVerified: Bool { get set }
    
    func sendVerifyingCode(validationCode: String)
    func sendPushGeneration(phoneNumber: String?)
    
}

class PhoneVerificationViewModelImplementation: PhoneVerificationViewModel {
    
    weak var view: PhoneVerificationView?
    
    var phoneNumber: String
    
    var phoneVerified: Bool
    
    let context: AppContext
    
    init() {
        context = AppDelegate.shared.context
        phoneNumber = ""
        phoneVerified = false
    }
    
    func sendVerifyingCode(validationCode: String) {
        let req = Requests.verifyToken(validationCode: validationCode)
        
        context.networkService.send(request: req) { [weak self] result in
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
    
    
    func sendPushGeneration(phoneNumber: String?) {
        let req = Requests.generateToken(phone: "+\(phoneNumber ?? self.phoneNumber)")
        context.networkService.send(request: req) { [weak self] result in
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
