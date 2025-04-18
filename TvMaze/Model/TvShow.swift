//
//  Shows.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

struct TvShow: Codable, Identifiable {
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
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network, webChannel: Network?
    let dvdCountry: Country?
    let externals: Externals?
    let image: TvShowImage?
    let summary: String?
    let updated: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

extension TvShow: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TvShow, rhs: TvShow) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Country
struct Country: Codable {
    let name: String?
    let code: String?
    let timezone: String?
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct TvShowImage: Codable {
    let medium, original: String?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass?
    let previousepisode: Episode?
    let nextepisode: Episode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String?
}

// MARK: - Episode
struct Episode: Codable {
    let href: String?
    let name: String?
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String?
    let days: [Day]?
}

enum Day: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

extension Day: Identifiable {
    var id: Self {
        self
    }
}
