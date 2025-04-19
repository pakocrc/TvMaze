//
//  TvMazeStore.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class TvMazeStore {
    static let shared = TvMazeStore()

    private init() { }

    func getMockTvShows() async throws -> [TvMazeShow] {
        debugPrint("Getting TvShows mock data...")

        let path = "TvMazeShows"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            throw error
        }
    }

    func getMockSeasons() async throws -> [TvMazeSeason] {
        debugPrint("Getting Seasons mock data...")

        let path = "TvMazeSeasons"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeSeason].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            throw error
        }
    }

    func getMockEpisodes() async throws -> [TvMazeEpisode] {
        debugPrint("Getting Episodes mock data...")

        let path = "TvMazeEpisodes"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeEpisode].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            throw error
        }
    }

    func getTvShow() -> TvMazeShow {
        return TvMazeShow(id: 43, url: "https://www.tvmaze.com/shows/43/outlander", name: "Outlander", type: "scripted", language: "english", genres: ["adventure", "romance", "scienceFiction"], status: "running", runtime: Optional(60), averageRuntime: 61, premiered: "2014-08-09", ended: nil, officialSite: Optional("https://www.starz.com/us/en/series/outlander/21796"), schedule: TvMazeSchedule(time: "20:00", days: [TvMazeDay.friday]), rating: TvMazeRating(average: Optional(7.9)), weight: 99, image: TvMazeImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/544/1362267.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/544/1362267.jpg"), summary: "<p><b>Outlander </b>follows the story of Claire Randall, a married combat nurse from 1945 who is mysteriously swept back in time to 1743, where she is immediately thrown into an unknown world where her life is threatened. When she is forced to marry Jamie, a chivalrous and romantic young Scottish warrior, a passionate affair is ignited that tears Claire\'s heart between two vastly different men in two irreconcilable lives.</p><p>The <i>Outlander</i> series, adapted from Diana Gabaldon\'s international best-selling books, spans the genres of romance, science fiction, history and adventure into one epic tale.</p>", updated: 1737502204)
    }
}
