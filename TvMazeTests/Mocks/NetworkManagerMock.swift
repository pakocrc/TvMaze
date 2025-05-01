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

        let path = "TvMazeShowsSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            return []
        }
    }
    
    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason] {
        debugPrint("Getting Seasons mock data...")

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
    
    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow] {
        let path = "TvMazeSearchSuccessful"
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
            debugPrint("❌ Error. Failed to load \(path)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([SearchTvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error \(error). Decode failed of data in", path)
            return []
        }
    }
    
    func fetchCast(showId: String) async throws -> [TvMazeCast] {

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
}
