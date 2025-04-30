//
//  Coordinator.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftUI

protocol Route { }

protocol Steps: Equatable, Hashable { }

protocol Coordinator: ObservableObject {
    associatedtype CoordinatorSteps: Steps
    associatedtype CoordinatorView: View
    var path: [CoordinatorSteps] { get set }
    func redirect(_ path: CoordinatorSteps) -> CoordinatorView

    func navigateToDetail(tvShow: TvMazeShow)

    func navigateToEpisodes(tvShow: TvMazeShow, seasons: [TvMazeSeason])

    func navigateToEpisodeDetails(episode: TvMazeEpisode)

    func navigateToCast(tvShow: TvMazeShow)
}
