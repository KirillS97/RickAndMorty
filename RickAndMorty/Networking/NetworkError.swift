//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Kirill on 21.08.2023.
//

import Foundation



enum NetworkError: Error, Equatable {
    case invalidURL
    case errorStatusCode
    case errorFromServer
    case noStatusCode
    case noData
    case dataWasNotDecoded
}
