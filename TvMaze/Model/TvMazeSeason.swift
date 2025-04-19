//
//  TvMazeSeason.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

struct TvMazeSeason: Codable, Identifiable {
    let id: Int
    let url: String?
    let number: Int?
    let name: String?
    let episodeOrder: Int?
    let premiereDate, endDate: String?
    let network: TvMazeNetwork
    let image: TvMazeImage?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, image, summary
    }
}
