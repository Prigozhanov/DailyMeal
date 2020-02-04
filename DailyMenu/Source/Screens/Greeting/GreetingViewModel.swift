//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking

//MARK: - View
protocol GreetingView: class {
    func closeView()
}

//MARK: - ViewModel
protocol GreetingViewModel {
    
    var view: GreetingView? { get set }
    
    var userName: String { get set }
    var password: String { get set }
    
    func performLogin()
}

//MARK: - Implementation
final class GreetingViewModelImplementation: GreetingViewModel {
    
    private let context: AppContext
    
    weak var view: GreetingView?
    
    var userName: String = "vprigozhanov@gmail.com"
    var password: String = ""
    
    init() {
        context = AppDelegate.shared.context
    }
    
    func performLogin() {
        let req = Requests.authenticate(userName: userName, password: password)
        LoadingIndicator.show()
        context.networkService.send(request: req) { [weak self] result in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                if let user = response.member {
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


