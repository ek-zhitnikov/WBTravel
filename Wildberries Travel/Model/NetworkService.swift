//
//  NetworkService.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFLights(completion: @escaping (Result<FlightResponse, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getFLights(completion: @escaping (Result<FlightResponse, Error>) -> Void) {
        
        let headers = [
            "authority": "vmeste.wildberries.ru",
            "accept": "application/json, text/plain, */*",
            "cache-control": "no-cache",
            "origin": "https://vmeste.wildberries.ru",
            "pragma": "no-cache",
            "referer": "https://vmeste.wildberries.ru/avia",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-origin"
        ]
        
        let parameters = ["startLocationCode": "LED"]

        var request = URLRequest(url: NSURL(string: "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
             }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotReceived))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FlightResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(NetworkError.dataParsingFailed))
            }
            
        }
        dataTask.resume()
    }
}
