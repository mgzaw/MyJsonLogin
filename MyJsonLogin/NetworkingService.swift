//
//  NetworkingService.swift
//  MyJsonLogin
//
//  Created by U Moe Nyo Gyi on 2021/08/01.
//

import Foundation

enum MyResult<T, E: Error> {
    case success(T)
    case failure(E)
}

class NetworkingService {
    let baseUrl = "https://api.menzei-net.com/"
    
    func request(endpoint: String,
                 loginObject: LoginInfo,
                 completion: @escaping (Result<UserInfo, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else {
            let NE = NetworkingError(statusCode: -1, message: "Bad URL")
            completion(.failure(NE))
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
        } catch {
            let NE = NetworkingError(statusCode: -1, message: "Bad Encoing")
            completion(.failure(NE))
            return
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, URLResponse, Error) in
            DispatchQueue.main.async {
                guard let unwrapprdResponse = URLResponse as? HTTPURLResponse else {
                    let NE = NetworkingError(statusCode: -1, message: "Bad Response")
                    completion(.failure(NE))
                    return
                }
                
                print(unwrapprdResponse.statusCode)
                
                switch unwrapprdResponse.statusCode {

                case 200 ..< 300:
                    print("success")

                default:
//                    print("failure")
                    let NE = NetworkingError(statusCode: unwrapprdResponse.statusCode, message: "123456")
                    completion(.failure(NE))
                    return
                }
                
//                if let unwrappedError = Error {
//                    completion(.failure(unwrappedError))
//                    return
//                }
                
                if let unwrappedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)
                        if let userinfo = try? JSONDecoder().decode(UserInfo.self, from: unwrappedData) {
                            completion(.success(userinfo))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            let NE = NetworkingError(statusCode: unwrapprdResponse.statusCode, message: "errorResponse.errorDescription!")
                            completion(.failure(NE))
                            return
                        }
                    } catch {
                        let NE = NetworkingError(statusCode: unwrapprdResponse.statusCode, message: "Bad Jeson")
                        completion(.failure(NE))
                        return
                    }
                }
            }
        }
        task.resume()
    }
}

struct NetworkingError: Error {
//    case badUrl
//    case badResponse
//    case badEncoding
//    case badJson
//    case badPassword
    
    let statusCode: Int
    let message: String
    
}
