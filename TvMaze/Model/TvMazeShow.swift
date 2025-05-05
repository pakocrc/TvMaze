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
    var id: String
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var averageRuntime: Int?
    var premiered: String?
    var ended: String?
    var officialSite: String?
    var schedule: TvMazeSchedule?
    var rating: TvMazeRating?
    var weight: Int?
    var network: TvMazeNetwork?
    var webChannel: TvMazeNetwork?
    var image: TvMazeImage?
    var summary: String?
    var updated: Int?
    var isFavorite: Bool

    init(id: String, url: String?, name: String?, type: String?, language: String?, genres: [String]?, status: String?, runtime: Int?, averageRuntime: Int?, premiered: String?, ended: String?, officialSite: String?, schedule: TvMazeSchedule?, rating: TvMazeRating?, weight: Int?, image: TvMazeImage?, summary: String? = nil, updated: Int?) {
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
        self.summary = summary?.htmlToString()
        self.updated = updated
        self.isFavorite = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id).description
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
