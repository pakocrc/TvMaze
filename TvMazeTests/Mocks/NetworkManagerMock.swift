//
//  NetworkManagerMock.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 29/4/25.
//

import Foundation

final class NetworkManagerMock: NetworkProtocol {
    func fetchShowsList(page: Int) async throws -> [TvMazeShow] {
        debugPrint("Getting TvShows mock data...")

        let path = page == 0 ? "TvMazeShowsSuccessful" : "TvMazeShowsUnsuccessful"
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

    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow] {
        debugPrint("Getting Search TvShows mock data...")

        if searchCriteria == "fail" {
            throw NetworkError.invalidData
        }

        let path = "TvMazeSearchSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([SearchTvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            throw error
        }
    }

    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason] {
        debugPrint("Getting Seasons mock data...")

        if showId == "fail" {
            throw NetworkError.invalidData
        }

        let path = "TvMazeSeasonsSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeSeason].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            return []
        }
    }
    
    func fetchEpisodeList(showId: String) async throws -> [TvMazeEpisode] {
        debugPrint("Getting Episodes mock data...")

        let path = "TvMazeEpisodesSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeEpisode].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            return []
        }
    }
    
    func fetchCast(showId: String) async throws -> [TvMazeCast] {
        debugPrint("Getting Cast mock data...")

        let path = "TvMazeCastSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeCast].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            return []
        }
    }
    
    func fetchImage(url: String) async throws -> Data {
        return Data()
    }

    func fetchPersonDetails(id: String) async throws -> TvMazePerson {
        debugPrint("Getting Person mock data...")

        let path = "TvMazePersonSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            throw NetworkError.invalidUrl
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(TvMazePerson.self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            throw NetworkError.decodingFailed
        }
    }

    func fetchShowImages(showId: String) async throws -> [TvMazeShowImage] {
        return []
    }
}
