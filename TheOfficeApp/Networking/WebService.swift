//
//  WebService.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case emptyData
    case decoderError(error: Error)
    case responseError(error: Error)
}

protocol WebServicing {
    func fetch<T: Decodable>(from endpoint: Endpoints,with class: T.Type, completion:  @escaping (Result<T, ServiceError>) -> Void)
}

class WebService: WebServicing {
    func fetch<T: Decodable>(from endpoint: Endpoints, with class: T.Type, completion:  @escaping (Result<T, ServiceError>) -> Void){
        guard let requestURL = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                DispatchQueue.main.async {
                    completion(.failure(.responseError(error: error)))
                }
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                
                do {
                    let episodeResponse = try decoder.decode(T.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(episodeResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decoderError(error: error)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.emptyData))
                }
            }
            
        }.resume()
    }
}
