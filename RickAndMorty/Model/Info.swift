//
//  Info.swift
//  RickAndMorty
//
//  Created by Kirill on 22.08.2023.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
