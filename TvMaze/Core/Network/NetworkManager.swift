//
//  NetworkManager.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

protocol Networking {
    func fetchShowsList(page: Int) async throws -> [TvMazeShow]
    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason]
    func fetchEpisodeList(showId: String) async throws -> [TvMazeEpisode]
    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow]
}

final class NetworkManager: Networking {
    // MARK: - Singleton
    static let shared = NetworkManager()

    // MARK: - Private
    private let baseUrl = "https://api.tvmaze.com"

    private init() {

    }

    private func validateAsyncResponse(_ response: HTTPURLResponse) throws -> Bool {
        switch response.statusCode {
            case 200...299:
                return true
            case 400...499:
                throw NetworkError.clientError(response.statusCode)
            case 500...599:
                throw NetworkError.serverError(response.statusCode)
            default:
                throw NetworkError.unknownError(response.statusCode)
        }
    }

    // MARK: - Protocol conformance
    func fetchShowsList(page: Int) async throws -> [TvMazeShow] {
        // https://api.tvmaze.com/shows?page=1
        guard let url = URL(string: String("\(baseUrl)/shows?page=\(String(page))")) else {
            throw NetworkError.invalidUrl
        }

        debugPrint("🛜 Url:", url.absoluteString)

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

            _ = try validateAsyncResponse(httpUrlResponse)

            return try JSONDecoder().decode([TvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error:", error.localizedDescription)
            throw NetworkError.decodingFailed
        }
    }

    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason] {
        // https://api.tvmaze.com/shows/43/seasons
        guard let url = URL(string: String("\(baseUrl)/shows/\(showId)/seasons")) else {
            throw NetworkError.invalidUrl
        }

        debugPrint("🛜 Url:", url.absoluteString)

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

            _ = try validateAsyncResponse(httpUrlResponse)

            return try JSONDecoder().decode([TvMazeSeason].self, from: data)

        } catch let error {
            debugPrint("❌ Error:", error.localizedDescription)
            throw NetworkError.decodingFailed
        }
    }

    func fetchEpisodeList(showId: String) async throws -> [TvMazeEpisode] {
        // https://api.tvmaze.com/shows/43/episodes
        guard let url = URL(string: String("\(baseUrl)/shows/\(showId)/episodes")) else {
            throw NetworkError.invalidUrl
        }

        debugPrint("🛜 Url:", url.absoluteString)

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

            _ = try validateAsyncResponse(httpUrlResponse)

            return try JSONDecoder().decode([TvMazeEpisode].self, from: data)

        } catch let error {
            debugPrint("❌ Error:", error.localizedDescription)
            throw NetworkError.decodingFailed
        }
    }

    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow] {
        // https://api.tvmaze.com/search/shows?q=outlander
        guard let url = URL(string: String("\(baseUrl)/search/shows?q=\(searchCriteria)")) else {
            throw NetworkError.invalidUrl
        }

        debugPrint("🛜 Url:", url.absoluteString)

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

            _ = try validateAsyncResponse(httpUrlResponse)

            return try JSONDecoder().decode([SearchTvMazeShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error:", error.localizedDescription)
            throw NetworkError.decodingFailed
        }
    }
}
