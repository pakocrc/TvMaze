//
//  CastViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import Foundation

final class CastViewModel: ObservableObject {
    @MainActor @Published var cast = [TvMazeCast]()

    @Published var selectedPersonId: String?

    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager

        fetchCast()
    }

    func fetchCast() {
        Task.detached { [weak self] in
            do {
                guard let fetchedCast = try await self?.networkManager.fetchCast(showId: self?.tvShow.showId.description ?? "") else { return }

                RunLoop.main.perform { [weak self] in
                    self?.cast = fetchedCast
                }

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
