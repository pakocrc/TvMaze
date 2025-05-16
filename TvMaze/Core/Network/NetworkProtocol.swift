//
//  NetworkProtocol.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 15/5/25.
//

import Foundation

protocol NetworkProtocol {
    func fetchShowsList(page: Int) async throws -> [TvMazeShow]
    func fetchSeasonList(showId: String) async throws -> [TvMazeSeason]
    func fetchEpisodeList(showId: String) async throws -> [TvMazeEpisode]
    func searchTvShow(searchCriteria: String) async throws -> [SearchTvMazeShow]
    func fetchCast(showId: String) async throws -> [TvMazeCast]
    func fetchImage(url: String) async throws -> Data
    func fetchPersonDetails(id: String) async throws -> TvMazePerson
    func fetchShowImages(showId: String) async throws -> [TvMazeShowImage]
}
