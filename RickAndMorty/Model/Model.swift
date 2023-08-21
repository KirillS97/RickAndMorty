//
//  Model.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import Foundation



struct Origin: Decodable {
    let name: String
    let url: String
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct AnswerFromServer: Decodable {
    let info: Info
    let results: [Character]
}

struct Episode: Decodable {
    let name: String
    let air_date: String
    let episode: String
    
}

extension Episode {
    
    var episodeDescription: String {
        let pattern = "S(.*)E(.*)"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let matches = regex.matches(in: episode,
                                        range: NSRange(location: 0, length: episode.utf16.count))
            if let match = matches.first {
                
                if let seasonRange = Range(match.range(at: 1), in: episode),
                   let episodeRange = Range(match.range(at: 2), in: episode),
                   let seasonNumber = Int(episode[seasonRange]),
                   let episodeNumber = Int(episode[episodeRange]) {
                    
                    let episodeDescription = "Episode: \(episodeNumber), Season: \(seasonNumber)"
                    return episodeDescription
                }
            }
        }
        return self.episode
    }
    
    var releaseDateInTimeInterval: TimeInterval {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, Y"
        if let date = dateFormatter.date(from: self.air_date) {
            return date.timeIntervalSince1970
        }
        return Date().timeIntervalSince1970
    }
    
}
