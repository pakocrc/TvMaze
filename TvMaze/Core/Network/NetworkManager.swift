//
//  NetworkManager.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

protocol Networking {
    func fetchShowsList(page: Int) async throws -> [TvShow]
}

final class NetworkManager: Networking {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.tvmaze.com"

    private init() {

    }

    func fetchShowsList(page: Int) async throws -> [TvShow] {
        guard let url = URL(string: String("\(baseUrl)/shows?page=\(String(page))")) else {
            throw NetworkError.invalidUrl
        }

        debugPrint("🛜 Url:", url.absoluteString)

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }

            _ = try validateAsyncResponse(httpUrlResponse)

            return try JSONDecoder().decode([TvShow].self, from: data)

        } catch let error {
            debugPrint("❌ Error:", error.localizedDescription)
            throw NetworkError.decodingFailed
        }
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
}
