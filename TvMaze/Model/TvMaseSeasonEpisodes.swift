//
//  TvMaseSeasonEpisodes.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

struct TvMaseSeasonEpisodes: Identifiable {
    let id = UUID()
    let season: TvMazeSeason
    let episodes: [TvMazeEpisode]
}
