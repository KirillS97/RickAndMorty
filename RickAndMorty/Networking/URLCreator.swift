//
//  URLCreator.swift
//  RickAndMorty
//
//  Created by Kirill on 21.08.2023.
//

import Foundation



struct URLCreator {
    
    static let shared = URLCreator(); private init() {}
    
    private let baseURL: URL? = URL(string: "https://rickandmortyapi.com")
    private let apiPath = "/api"
    private let charactersPath = "/character"
    
    func getCharactersForPageURL(pageNumber: Int) -> URL? {
        guard let baseURL else { return nil }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path.append(contentsOf: self.apiPath)
        urlComponents?.path.append(contentsOf: self.charactersPath)
        let queryItem = URLQueryItem(name: "page", value: String(pageNumber))
        urlComponents?.queryItems = [queryItem]
        return urlComponents?.url
    }
}
