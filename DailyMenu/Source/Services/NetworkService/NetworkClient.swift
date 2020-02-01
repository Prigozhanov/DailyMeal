//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public final class NetworkClient {
    
    public enum Error: Swift.Error {
        case unknownError
    }
    
    private let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
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
            
            switch response.statusCode {
            case 200 ..< 300:
                do {
                    let jsonDecoder = JSONDecoder()
                    guard let data = data else {
                        return
                    }
                    let jsonResponse = try jsonDecoder.decode(Response.self, from: data)
                    successClosure(jsonResponse)
                } catch {
                    print(error)
                }
            default:
                
                break
            }
        }
        
        task.resume()
    }
    
    public func loadImage(link: String?, completion: @escaping (Data) -> Void) {
        guard let link = link else { return }
        let task = session.dataTask(with: URL(string: link)!, completionHandler: { (data, response, eror) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        })
        task.resume()
        
    }
    
}
