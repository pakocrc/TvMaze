////
////  FavoritesCoordinator.swift
////  TvMaze
////
////  Created by Francisco Cordoba on 18/4/25.
////
//
//import Foundation
//import SwiftUI
//
//enum FavoritesSteps: Steps {
//    case favoritesList
//    case showDetail(TvMazeShow)
//    case episodes(TvMazeShow, [TvMazeSeason])
//    case cast(TvMazeShow)
//    case episodeDetail(TvMazeEpisode)
//}
//
//extension FavoritesSteps: Identifiable, Equatable {
//    var id: UUID {
//        UUID()
//    }
//
//    static func == (lhs: FavoritesSteps, rhs: FavoritesSteps) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//final class FavoritesCoordinatorView: ObservableObject {
//    @Published var path = [FavoritesSteps]()
//
//    init() { }
//
//    func navigateToDetail(tvShow: TvMazeShow) {
//        path.append(.showDetail(tvShow))
//    }
//
//    func navigateToEpisodes(tvShow: TvMazeShow, seasons: [TvMazeSeason]) {
//        path.append(.episodes(tvShow, seasons))
//    }
//
//    func navigateToEpisodeDetails(episode: TvMazeEpisode) {
//        path.append(.episodeDetail(episode))
//    }
//
//    func navigateToCast(tvShow: TvMazeShow) {
//        path.append(.cast(tvShow))
//    }
//
//    func goBack() {
//        path.removeLast()
//    }
//}
//
//extension FavoritesCoordinatorView: Coordinator {
//    @ViewBuilder
//    func redirect(_ path: FavoritesSteps) -> some View {
//        switch path {
//            case .favoritesList:
//                FavoritesView(viewModel: FavoritesViewModel(coordinator: self))
////            case .showDetail(let tvShow):
////                ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: tvShow, coordinator: self))
////            case .episodes(let tvShow, let seasons):
////                ShowEpisodesView(viewModel: ShowEpisodesViewModel(tvShow: tvShow, seasons: seasons, coordinator: self))
////            case .episodeDetail(let episode):
////                EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: episode, coordinator: self))
////            case .cast(let tvShow):
////                CastView(viewModel: CastViewModel(tvShow: tvShow, coordinator: self))
//        }
//    }
//}
