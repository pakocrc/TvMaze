//
//  TvMazeShow.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation
import SwiftData

@Model
class TvMazeShow: Identifiable {
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
//    let network: TvMazeNetwork?
    let webChannel: TvMazeNetwork?
    let image: TvMazeImage?
    var summary: String?
    let updated: Int?
    var isFavorite: Bool

    init(id: Int, url: String?, name: String?, type: String?, language: String?, genres: [String]?, status: String?, runtime: Int?, averageRuntime: Int?, premiered: String?, ended: String?, officialSite: String?, schedule: TvMazeSchedule?, rating: TvMazeRating?, weight: Int?, image: TvMazeImage?, summary: String? = nil, updated: Int?) {
        self.id = id
        self.url = url
        self.name = name
        self.type = type
        self.language = language
        self.genres = genres
        self.status = status
        self.runtime = runtime
        self.averageRuntime = averageRuntime
        self.premiered = premiered
        self.ended = ended
        self.officialSite = officialSite
        self.schedule = schedule
        self.rating = rating
        self.weight = weight
        self.image = image
        self.summary = summary
        self.updated = updated
        self.isFavorite = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        genres = try container.decodeIfPresent([String].self, forKey: .genres)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        averageRuntime = try container.decodeIfPresent(Int.self, forKey: .averageRuntime)
        premiered = try container.decodeIfPresent(String.self, forKey: .premiered)
        ended = try container.decodeIfPresent(String.self, forKey: .ended)
        officialSite = try container.decodeIfPresent(String.self, forKey: .officialSite)
        schedule = try container.decodeIfPresent(TvMazeSchedule.self, forKey: .schedule)
        rating = try container.decodeIfPresent(TvMazeRating.self, forKey: .rating)
        weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        image = try container.decodeIfPresent(TvMazeImage.self, forKey: .image)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)?.htmlToString()
        updated = try container.decodeIfPresent(Int.self, forKey: .updated)
        isFavorite = false
    }

    func setFavorite() {
        self.isFavorite.toggle()
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

extension TvMazeShow: Codable {
    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, image, summary, updated
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(genres, forKey: .genres)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(runtime, forKey: .runtime)
        try container.encodeIfPresent(averageRuntime, forKey: .averageRuntime)
        try container.encodeIfPresent(premiered, forKey: .premiered)
        try container.encodeIfPresent(ended, forKey: .ended)
        try container.encodeIfPresent(officialSite, forKey: .officialSite)
        try container.encodeIfPresent(schedule, forKey: .schedule)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(updated, forKey: .updated)
    }
}
