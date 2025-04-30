//
//  TvMazePerson.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

struct TvMazePerson: Codable {
    let id: Int
    let url: String?
    let name: String?
    let country: TvMazeCountry?
    let birthday: String?
    let deathday: String?
    let gender: TvMazeGender?
    let image: TvMazeImage?
    let links: TvMazeLinks?

    enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image
        case links = "_links"
    }
}
