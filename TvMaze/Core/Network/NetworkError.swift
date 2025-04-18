//
//  NetworkError.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case decodingFailed
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidUrl:
                return "❌ Invalid URL, impossible to execute the request."
            case .invalidResponse:
                return "❌ Invalid response received from the server."
            case .invalidData:
                return "❌ Invalid data retrieved from the server."
            case .decodingFailed:
                return "❌ Failed to decode the response data."
            case .clientError(let statusCode):
                return "❌ Client error occurred. Status code: \(statusCode)"
            case .serverError(let statusCode):
                return "❌ Server error occurred. Status code: \(statusCode)"
            case .unknownError(let statusCode):
                return "❌ An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
