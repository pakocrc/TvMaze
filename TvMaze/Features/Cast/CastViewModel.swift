//
//  CastViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import Foundation

final class CastViewModel: ObservableObject {
    @Published var cast = [TvMazeCast]()
    @Published var selectedPersonId: String?
    @Published var displayAlert = false
    @Published var alertMessage = ""
    @Published var isReloadEnabled = false

    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager
    }

    @MainActor
    func fetchCast() async {
        do {
            cast = try await networkManager.fetchCast(showId: tvShow.id)

        } catch let error {
            debugPrint(error.localizedDescription)
            displayAlert.toggle()
            isReloadEnabled = true
            alertMessage = error.localizedDescription
        }
    }
}
