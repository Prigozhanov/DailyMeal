//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public final class NetworkClient {
    
    public enum Error: String, Swift.Error {
        case unknownError
        case parsingError
        case missingData
    }
    
    private let session: URLSession
    
    private var sessionQueue: OperationQueue
    
    init() {
        sessionQueue = OperationQueue()
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: sessionQueue)
    }
    
    public func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, Error>) -> Void) {
        let request = URLRequestBuilder(request: request)
        
        let task = session.dataTask(with: request.urlRequest) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
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
                    print(jsonResponse)
                } catch {
                    failureClosure(Error.parsingError)
                }
            default:
                failureClosure(Error.unknownError)
            }
        }
        
        task.resume()
    }
    
}
