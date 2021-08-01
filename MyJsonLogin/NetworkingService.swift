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
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
        } catch {
            completion(.failure(NetworkingError.badEncoding))
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, URLResponse, Error) in
            DispatchQueue.main.async {
                guard let unwrapprdResponse = URLResponse as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unwrapprdResponse.statusCode)
                
                switch unwrapprdResponse.statusCode {
                
                case 200 ..< 300:
                    print("success")
                    
                default:
                    print("failure")
                }
                
                if let unwrappedEror = Error {
                    completion(.failure(unwrappedEror))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let userinfo = try? JSONDecoder().decode(UserInfo.self, from: unwrappedData) {
                            completion(.success(userinfo))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        completion(.failure(NetworkingError.badJson))
                    }
                }
            }
        }
        task.resume()
    }
}

enum NetworkingError: Error {
    case badUrl
    case badResponse
    case badEncoding
    case badJson
    case badPassword
}
