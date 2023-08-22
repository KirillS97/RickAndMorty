//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import UIKit



final class NetworkManager {
    static let shared = NetworkManager(); private init() {}
    
    func fetchCharacters(url: URL?,
                         completionHandler: @escaping (Result<AnswerFromServer, NetworkError>) -> Void) -> Void {
        
        guard let safeUrl = url else {
            DispatchQueue.main.async { completionHandler(.failure(.invalidURL)) }; return
        }
        let urlRequest = URLRequest(url: safeUrl)
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                print("error")
                DispatchQueue.main.async { completionHandler(.failure(.errorFromServer)) }; return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if !(200..<300).contains(httpResponse.statusCode) {
                    print("statusCode")
                    DispatchQueue.main.async { completionHandler(.failure(.errorStatusCode)) }; return
                }
            }
            guard let safeData = data else {
                DispatchQueue.main.async { completionHandler(.failure(.noData)) }; return
            }
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(AnswerFromServer.self, from: safeData) else {
                DispatchQueue.main.async { completionHandler(.failure(.dataWasNotDecoded)) }; return
            }
            DispatchQueue.main.async {
                completionHandler(.success(decodedData))
            }
        }
        dataTask.resume()
    }
    
    
    
    func fetchEpisodesArray(urlArray: [URL?], completionHandler: @escaping (Result<[Episode], NetworkError>) -> Void) {
        var episodesArray: [Episode] = []
        for i in 0..<urlArray.count {
            guard let safeUrl = urlArray[i] else {
                DispatchQueue.main.async { completionHandler(.failure(.invalidURL)) }; return
            }
            let urlSession = URLSession(configuration: .default)
            let urlRequest = URLRequest(url: safeUrl)
            let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    DispatchQueue.main.async { completionHandler(.failure(.errorFromServer)) }; return
                }
                guard let safeData = data else {
                    DispatchQueue.main.async { completionHandler(.failure(.noData)) }; return
                }
                let jsonDecoder = JSONDecoder()
                guard let decodedData = try? jsonDecoder.decode(Episode.self, from: safeData) else {
                    DispatchQueue.main.async { completionHandler(.failure(.dataWasNotDecoded)) }; return
                }
                episodesArray.append(decodedData)
                if i == urlArray.index(before: urlArray.endIndex) {
                    DispatchQueue.main.async {
                        completionHandler(.success(episodesArray))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    
    
    func fetchImage(url: URL?,
                    task: inout URLSessionDataTask!,
                    completionHandler: @escaping (UIImage?) -> Void ) {
        if let task { task.cancel() }
        guard let safeUrl = url else {
            DispatchQueue.main.async { completionHandler(nil) }; return
        }
        let urlRequest = URLRequest(url: safeUrl)
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let safeData = data {
                if let image = UIImage(data: safeData) {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        }
        task = dataTask
        task.resume()
    }
    
    
}
