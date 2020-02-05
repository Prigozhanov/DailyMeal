//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public final class NetworkClient {
    
    public enum Error: String, Swift.Error {
        case unknownError
        case parsingError
        case serverSideError
        case missingData
        case unauthorized
    }
    
    private let sessionQueue: OperationQueue
    private let session: URLSession
    private let urlRequestConfigurator: URLRequestConfigurator
    
    public init(urlRequestConfigurator: URLRequestConfigurator) {
        sessionQueue = OperationQueue()
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: sessionQueue)
        self.urlRequestConfigurator = urlRequestConfigurator
    }
    
    public func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, Error>) -> Void) {
        var urlRequest = URLRequestBuilder(request: request).urlRequest
        
        urlRequestConfigurator.configure(request: &urlRequest)
        
        print("[NETWORK] [REQUEST] \(urlRequest)")
        print("[NETWORK] [REQUEST] [HEADERS] \(String(describing: urlRequest.allHTTPHeaderFields))")
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
//            print("[NETWORK] [RESPONSE] \(response.debugDescription)")
            
            let successClosure: (Response) -> Void = { response in
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            
            let failureClosure: (Error) -> Void = { error in
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            switch response.statusCode {
            case 200 ..< 300:
                do {
                    let jsonDecoder = JSONDecoder()
                    guard let data = data else {
                        failureClosure(Error.missingData)
                        return
                    }
                    let jsonResponse = try jsonDecoder.decode(Response.self, from: data)
                    successClosure(jsonResponse)
                } catch {
                    print(error)
                    failureClosure(Error.parsingError)
                }
            case 403:
                failureClosure(Error.unauthorized)
            case 500:
                failureClosure(Error.serverSideError)
            default:
                failureClosure(Error.unknownError)
            }
        }
        
        task.resume()
    }
    
}
