//
//  ChatService.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

protocol ChatServiceProtocol {
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], CustomError>) -> Void)
}

class ChatService: ChatServiceProtocol {
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], CustomError>) -> Void) {
        request(route: .sendMessage(message)) { (result: Result<[Message], CustomError>) in
            completion(result)
        }
    }
    
    func request<T: Codable>(route: Route, completion: @escaping (Result<T, CustomError>) -> Void) {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = route.queryItems
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.network))
                return
            }
            
            guard response != nil else {
                completion(.failure(.api))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.parse))
            }
        }
        
        dataTask.resume()
    }
}

extension ChatService {
    enum Route {
        case sendMessage(_ message: String)
        
        var scheme: String {
            return "https"
        }
        
        var host: String {
            return "api.swiftui-chat-app.com"
        }
        
        var path: String {
            switch self {
            case .sendMessage:
                return "/message"
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case let .sendMessage(message):
                return [URLQueryItem(name: "message", value: message)]
            }
        }
        
        var method: String {
            switch self {
            case .sendMessage:
                return "POST"
            }
        }
    }
}
