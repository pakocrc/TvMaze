//
//  TvMazeShow.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

struct TvMazeShow: Codable, Identifiable {
    let id: Int
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: TvMazeSchedule?
    let rating: TvMazeRating?
    let weight: Int?
    let network, webChannel: TvMazeNetwork?
    let image: TvMazeImage?
    var summary: String?
    let updated: Int?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, image, summary, updated
    }
}

extension TvMazeShow: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TvMazeShow, rhs: TvMazeShow) -> Bool {
        return lhs.id == rhs.id
    }
}
