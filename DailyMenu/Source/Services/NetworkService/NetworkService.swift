//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol NetworkServiceHolder {
    var networkService: NetworkService { get }
}

public protocol NetworkService {
    
    func send<Response: Codable>(request: Request<Response>, comletion: @escaping (Result<Response, NetworkClient.Error>) -> Void)
    
    func loadImage(link: String?, comletion: @escaping (Data) -> Void)

}

class NetworkServiceImplementation: NetworkService {
    
    private let networkClient = NetworkClient()
    
    
    func send<Response: Codable>(request: Request<Response>, comletion: @escaping (Result<Response, NetworkClient.Error>) -> Void) {
        networkClient.send(request: request, completion: comletion)
    }
    
    func loadImage(link: String?, comletion: @escaping (Data) -> Void) {
        networkClient.loadImage(link: link, completion: comletion)
    }
    
}
