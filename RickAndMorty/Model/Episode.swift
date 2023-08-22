//
//  Episode.swift
//  RickAndMorty
//
//  Created by Kirill on 22.08.2023.
//

import Foundation

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
