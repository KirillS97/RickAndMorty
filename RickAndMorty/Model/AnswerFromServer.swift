//
//  AnswerFromServer.swift
//  RickAndMorty
//
//  Created by Kirill on 22.08.2023.
//

import Foundation

struct AnswerFromServer: Decodable {
    let info: Info
    let results: [Character]
}
