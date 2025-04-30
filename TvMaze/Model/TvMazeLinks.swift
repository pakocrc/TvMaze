//
//  TvMazeLinks.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

struct TvMazeSelfClass: Codable {
    let href: String?
}

struct TvMazeLinks: Codable {
    let linksSelf: TvMazeSelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
