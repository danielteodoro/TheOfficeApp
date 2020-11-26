//
//  WebService.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

protocol WebServicing {
    func fetchEpisodes(completion:  @escaping (Result<[Episode], Error>) -> Void)
}

class WebService: WebServicing {
    func fetchEpisodes(completion:  @escaping (Result<[Episode], Error>) -> Void){
        var request = URLRequest(url:Endpoints().episodes())
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                
                do {
                    let episodeResponse = try decoder.decode(EpisodeResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(episodeResponse.data))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
