//
//  ShowCoordinator.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

//import Foundation
//import SwiftUI
//
//protocol Steps: Equatable, Hashable { }
//
//enum ShowSteps: Steps {
//    case showList
//    case favoritesList
//    case showDetail(TvMazeShow)
//    case episodes(TvMazeShow, [TvMazeSeason])
//    case cast(TvMazeShow)
//    case episodeDetail(TvMazeEpisode)
//}
//
//extension ShowSteps: Identifiable {
//    var id: UUID {
//        UUID()
//    }
//
//    static func == (lhs: ShowSteps, rhs: ShowSteps) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
/*
final class ShowCoordinatorView: ObservableObject {
    @Published var path = [ShowSteps]()
    let networkService: NetworkManager

    init() {
        self.networkService = NetworkManager()
    }

    func navigateToDetail(tvShow: TvMazeShow) {
        path.append(.showDetail(tvShow))
    }

    func navigateToEpisodes(tvShow: TvMazeShow, seasons: [TvMazeSeason]) {
        path.append(.episodes(tvShow, seasons))
    }

    func navigateToEpisodeDetails(episode: TvMazeEpisode) {
        path.append(.episodeDetail(episode))
    }

    func navigateToCast(tvShow: TvMazeShow) {
        path.append(.cast(tvShow))
    }

    func pop() {
        path.removeLast()
    }
}

extension ShowCoordinatorView: Coordinator {
    @ViewBuilder
    func redirect(_ path: ShowSteps) -> some View {
        switch path {
            case .showList:
                ShowListView(viewModel: ShowListViewModel(networkManager: self.networkService, coordinator: self))
            case .favoritesList:
                FavoritesView(viewModel: FavoritesViewModel(coordinator: self))
            case .showDetail(let tvShow):
                ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: tvShow, networkManager: self.networkService, coordinator: self))
            case .episodes(let tvShow, let seasons):
                ShowEpisodesView(viewModel: ShowEpisodesViewModel(tvShow: tvShow, seasons: seasons, networkManager: self.networkService, coordinator: self))
            case .episodeDetail(let episode):
                EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: episode, coordinator: self))
            case .cast(let tvShow):
                CastView(viewModel: CastViewModel(tvShow: tvShow, networkManager: self.networkService, coordinator: self))
        }
    }
}
*/
