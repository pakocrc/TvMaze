//
//  NetworkManagerMock.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 29/4/25.
//

import Foundation

final class NetworkManagerMock: NetworkProtocol {

    // MARK: - fetchShowsList
    func fetchShowsList(page: Int) async throws -> [TvMazeShow] {
        debugPrint("Getting TvShows mock data...")

        let path = page == 0 ? "TvMazeShowsSuccessful" : "TvMazeShowsFail"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Path:", path)
            throw error
        }
    }

    // MARK: - searchTvShow
    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow] {
        debugPrint("Getting Search TvShows mock data...")

        if searchCriteria == "fail" {
            throw NetworkError.invalidData
        }

        let path = searchCriteria == "fail" ? "TvMazeSearchFail" : "TvMazeSearchSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([SearchTvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }

    // MARK: - fetchSeasonList
    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason] {
        debugPrint("Getting Seasons mock data...")

        let path = showId == "fail" ? "TvMazeSeasonsFail" : "TvMazeSeasonsSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeSeason].self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }

    // MARK: - fetchEpisodeList
    func fetchEpisodeList(showId: String) async throws -> [TvMazeEpisode] {
        debugPrint("Getting Episodes mock data...")

        let path = showId == "fail" ? "TvMazeEpisodesFail" : "TvMazeEpisodesSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeEpisode].self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }

    // MARK: - fetchCast
    func fetchCast(showId: String) async throws -> [TvMazeCast] {
        debugPrint("Getting Cast mock data...")

        let path = showId == "fail" ? "TvMazeCastFail" : "TvMazeCastSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeCast].self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }

    // MARK: - fetchImage
    func fetchImage(url: String) async throws -> Data {
        return Data()
    }

    // MARK: - fetchPersonDetails
    func fetchPersonDetails(id: String) async throws -> TvMazePerson {
        debugPrint("Getting Person mock data...")

        let path = id == "fail" ? "TvMazePersonFail" : "TvMazePersonSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(TvMazePerson.self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }

    // MARK: - fetchShowImages
    func fetchShowImages(showId: String) async throws -> [TvMazeShowImage] {
        debugPrint("Getting Show Images mock data...")

        let path = showId == "fail" ? "TvMazeShowImagesFail" : "TvMazeShowImagesSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeShowImage].self, from: data)

        } catch let error {
            debugPrint("❌ [LOG] Error path: \(path). Error description: \(error)")
            throw error
        }
    }
}
