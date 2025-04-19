//
//  ShowCoordinator.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftUI

enum ShowSteps: Steps {
    case showList, showDetail(TvMazeShow), episodes(TvMazeShow, [TvMazeSeason]), episodeDetail(TvMazeEpisode)
}

extension ShowSteps: Identifiable, Equatable {
    var id: UUID {
        UUID()
    }

    static func == (lhs: ShowSteps, rhs: ShowSteps) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class ShowCoordinatorView: ObservableObject {
    @Published var path = [ShowSteps]()

    init() { }

    func navigateToDetail(tvShow: TvMazeShow) {
        path.append(.showDetail(tvShow))
    }

    func navigateToEpisodes(tvShow: TvMazeShow, seasons: [TvMazeSeason]) {
        path.append(.episodes(tvShow, seasons))
    }

    func navigateToEpisodeDetails(episode: TvMazeEpisode) {
        path.append(.episodeDetail(episode))
    }

    func goBack() {
        path.removeLast()
    }
}

extension ShowCoordinatorView: Coordinator {
    @ViewBuilder
    func redirect(_ path: ShowSteps) -> some View {
        switch path {
            case .showList:
                ShowListView(viewModel: ShowListViewModel(coordinator: self))
            case .showDetail(let tvShow):
                ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: tvShow, coordinator: self))
            case .episodes(let tvShow, let seasons):
                ShowEpisodesView(viewModel: ShowEpisodesViewModel(tvShow: tvShow, seasons: seasons, coordinator: self))
            case .episodeDetail(let episode):
                EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: episode, coordinator: self))
        }
    }
}
