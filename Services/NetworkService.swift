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

    var requestFactory: RequestFactory { get }
    
    func fetchUserData(onSuccess: @escaping (User) -> Void, onFailure: @escaping () -> Void)
    
    @discardableResult
    func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, NetworkClient.Error>, String) -> Void) -> URLSessionDataTask
    
}

public class NetworkServiceImplementation: NetworkService {
    
    private let networkClient: NetworkClient
    
    private let keychainService: KeychainService
    private let userDefaultsService: UserDefaultsService
    
    private let requestConfigurator: URLRequestConfigurator
    
    public var requestFactory: RequestFactory
    
    public init(keychainService: KeychainService, userDefaultsService: UserDefaultsService) {
        self.keychainService = keychainService
        self.userDefaultsService = userDefaultsService
        requestConfigurator = URLRequestConfigurator()
        networkClient = NetworkClient(urlRequestConfigurator: requestConfigurator)
        requestFactory = RequestFactory()
        if let token = keychainService.getValueForItem(.authToken) {
            requestConfigurator.addHeader(Header(httpHeaderField: .authorization, value: token))
        }
    }
    
    @discardableResult
    public func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, NetworkClient.Error>, String) -> Void) -> URLSessionDataTask {
        
        return networkClient.send(request: request) { [weak self] result, uuid in
            switch result {
            case let .success(response):
                self?.handleLogin(response: response)
                completion(result, uuid)
            case let .failure(error):
                switch error {
                case .unauthorized:
                    self?.handleUnauthorized()
                    completion(result, uuid)
                default:
                    completion(result, uuid)
                }
            }
        }
    }
    
    func handleLogin<Response: Codable>(response: Response) {
        if let token = (response as? LoginResponse)?.token {
            requestConfigurator.addHeader(Header(httpHeaderField: .authorization, value: token))
            keychainService.setValueForItem(.authToken, token)
        }
    }
    
    func handleUnauthorized() {
        keychainService.removeValue(.authToken)
        keychainService.removeValue(.JWTToken)
        requestConfigurator.removeHeader(.authorization)
    }
    
    public func fetchUserData(onSuccess: @escaping (User) -> Void, onFailure: @escaping () -> Void) {
        let req = requestFactory.user()
        
        send(request: req) { [weak self] result, _ in
            switch result {
            case let .success(user):
                self?.userDefaultsService.updateUserDetails(user: user)
                onSuccess(user)
            case let .failure(error):
                print(error)
                self?.handleUnauthorized()
                onFailure()
            }
        }
    }
    
}

public extension NotificationDescriptor {
    
    static var userLoggedInDescriptor: NotificationDescriptor<Void> {
        return NotificationDescriptor<Void>(name: .userLoggedIn) { _ in }
    }
    
    static var userLoggedOutDescriptor: NotificationDescriptor<Void> {
        return NotificationDescriptor<Void>(name: .userLoggedOut) { _ in }
    }
    
}
