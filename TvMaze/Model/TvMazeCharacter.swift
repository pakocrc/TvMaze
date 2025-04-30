//
//  TvMazeCharacter.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

struct TvMazeCharacter: Codable {
    let id: Int
    let url: String
    let name: String
    let image: TvMazeImage?
    let links: TvMazeLinks?

    enum CodingKeys: String, CodingKey {
        case id, url, name, image
        case links = "_links"
    }
}
