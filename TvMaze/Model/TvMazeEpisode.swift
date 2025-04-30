//
//  TvMazeEpisode.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

struct TvMazeEpisode: Identifiable {
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

    init(id: Int, url: String?, name: String?, season: Int?, number: Int?, type: String?, airdate: String?, airtime: String?, airstamp: String?, runtime: Int?, rating: TvMazeRating?, image: TvMazeImage?, summary: String?) {
        self.id = id
        self.url = url
        self.name = name
        self.season = season
        self.number = number
        self.type = type
        self.airdate = airdate
        self.airtime = airtime
        self.airstamp = airstamp
        self.runtime = runtime
        self.rating = rating
        self.image = image
        self.summary = summary?.htmlToString()
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

extension TvMazeEpisode: Codable {
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.season, forKey: .season)
        try container.encodeIfPresent(self.number, forKey: .number)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.airdate, forKey: .airdate)
        try container.encodeIfPresent(self.airtime, forKey: .airtime)
        try container.encodeIfPresent(self.airstamp, forKey: .airstamp)
        try container.encodeIfPresent(self.runtime, forKey: .runtime)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encodeIfPresent(self.summary, forKey: .summary)
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.season = try container.decodeIfPresent(Int.self, forKey: .season)
        self.number = try container.decodeIfPresent(Int.self, forKey: .number)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.airdate = try container.decodeIfPresent(String.self, forKey: .airdate)
        self.airtime = try container.decodeIfPresent(String.self, forKey: .airtime)
        self.airstamp = try container.decodeIfPresent(String.self, forKey: .airstamp)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.rating = try container.decodeIfPresent(TvMazeRating.self, forKey: .rating)
        self.image = try container.decodeIfPresent(TvMazeImage.self, forKey: .image)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)?.htmlToString()
    }
}
