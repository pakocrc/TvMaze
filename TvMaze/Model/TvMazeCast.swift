//
//  TvMazeCast.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import Foundation

struct TvMazeCast: Codable, Identifiable {
    let id = UUID()
    let person: TvMazePerson
    let character: TvMazeCharacter

    enum CodingKeys: String, CodingKey {
        case person, character
    }
}

extension TvMazeCast: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: TvMazeCast, rhs: TvMazeCast) -> Bool {
        return lhs.id == rhs.id
    }
}
