//
//  EpisodeDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class EpisodeDetailsViewModel: ObservableObject {
    @Published var episode: TvMazeEpisode

    init(episode: TvMazeEpisode) {
        self.episode = episode
    }
}
