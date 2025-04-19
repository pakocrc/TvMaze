//
//  EpisodeDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class EpisodeDetailsViewModel: ObservableObject {
    @Published var episode: TvMazeEpisode

    let coordinator: ShowCoordinatorView

    init(episode: TvMazeEpisode, coordinator: ShowCoordinatorView) {
        self.episode = episode
        self.coordinator = coordinator
    }
}
