//
//  ShowListViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Foundation

final class ShowListViewModel: ObservableObject {
    @Published var tvShowList: [TvShow] = []
    @Published var currentLastItem: TvShow?

    private var page = 0

    init() {
        Task {
            await fetchShowsList()
        }
    }

    @MainActor
    func fetchShowsList() {
        Task {
            do {
                let newTvShows = try await NetworkManager.shared.fetchShowsList(page: self.page)
                self.tvShowList.append(contentsOf: newTvShows)
                self.currentLastItem = self.tvShowList.last
                self.page += 1

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
