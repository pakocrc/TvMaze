//
//  TvMazeEpisode.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

struct TvMazeEpisode: Codable, Identifiable {
    let id: Int
    let url: String?
    let name: String?
    let season, number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: TvMazeRating?
    let image: TvMazeImage?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
    }
}

extension TvMazeEpisode: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TvMazeEpisode, rhs: TvMazeEpisode) -> Bool {
        return lhs.id == rhs.id
    }
}
