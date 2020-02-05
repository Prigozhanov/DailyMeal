//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking
import Extensions

public protocol NetworkServiceHolder {
    var networkService: NetworkService { get }
}

public protocol NetworkService {
    
    func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, NetworkClient.Error>) -> Void)
    
}

public class NetworkServiceImplementation: NetworkService {
    
    private let networkClient: NetworkClient
    
    private let keychainService: KeychainService
    
    private let requestConfigurator: URLRequestConfigurator
    
    public init(keychainService: KeychainService) {
        self.keychainService = keychainService
        requestConfigurator = URLRequestConfigurator()
        networkClient = NetworkClient(urlRequestConfigurator: requestConfigurator)
    }
    
    
    public func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, NetworkClient.Error>) -> Void) {
        networkClient.send(request: request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.handleLogin(response: response)
                completion(result)
            case let .failure(error):
                switch error {
                case .unauthorized:
                    completion(result)
                default:
                    completion(result)
                }
            }
        }
    }
    
    func handleLogin<Response: Codable>(response: Response) {
        if let token = (response as? LoginResponse)?.token {
            requestConfigurator.addHeader(Header(httpHeaderField: .authorization, value: token))
            keychainService.setValueForItem(.authToken, token)
            NotificationCenter.default.post(name: .userLoggedIn, object: response)
        }
    }
    
}

public extension NotificationDescriptor {
    
    static var userLoggedInDescriptor: NotificationDescriptor<User> {
        return NotificationDescriptor<User>(name: .userLoggedIn) { notification -> User in
            notification.object as! User
        }
    }
    
    static var userLoggedOutDescriptor: NotificationDescriptor<Void> {
        return NotificationDescriptor<Void>(name: .userLoggedOut) { _ in }
    }
    
}
