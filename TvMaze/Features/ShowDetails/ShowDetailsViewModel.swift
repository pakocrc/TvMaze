//
//  ShowDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class ShowDetailsViewModel: ObservableObject {
    @MainActor @Published var seasons = [TvMazeSeason]()
    @Published var isPresentingImageFullView = false
    @Published var presentShowEpisodes = false
    @Published var presentShowCast = false
    @Published var presentShowImages = false
    @Published var displayAlert = false
    @Published var alertMessage = ""
    
    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager
    }

    @MainActor
    func fetchEpisodeList() async {
        do {
            self.seasons = try await networkManager.fetchSeasonList(showId: String(self.tvShow.id))

        } catch let error {
            debugPrint(error.localizedDescription)
            displayAlert.toggle()
            alertMessage = error.localizedDescription
        }
    }
}
