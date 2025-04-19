//
//  ShowListViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import Combine
import Foundation

final class ShowListViewModel: ObservableObject {
    @Published var tvShowList = [TvMazeShow]()
    @Published var searchTvShowList = [TvMazeShow]()
    @Published var currentLastItem: TvMazeShow?
    @Published var searchCriteria: String = ""
    @Published var isSearching = false

    private var page = 0
    private var cancellables = Set<AnyCancellable>()

    init() {
        Task {
            await fetchShowsList()
        }

        bindPublishers()
    }

    private func bindPublishers() {
        $searchCriteria
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .filter({ $0.count > 3 })
            .sink(receiveValue: { [weak self] searchCriteria in

                DispatchQueue.main.async {
                    self?.searchShow(searchCriteria: searchCriteria)
                }
            }).store(in: &cancellables)

        $isSearching
            .dropFirst()
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { [weak self] isSearching in
                if !isSearching {
                    self?.searchTvShowList.removeAll()
                }
            }.store(in: &cancellables)
    }

    @MainActor
    func searchShow(searchCriteria: String) {
        Task {
            do {
                debugPrint("On searchShow()")
                let searchTvMazeShowResult = try await NetworkManager.shared.searchTvShow(searchCriteria: searchCriteria)
                self.searchTvShowList = searchTvMazeShowResult.map({ $0.show })

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    @MainActor
    func fetchShowsList() {
        Task {
            do {
#if !DEBUG
                self.tvShowList = try await TvMazeStore.shared.getMockTvShows()
#else
                let newTvShows = try await NetworkManager.shared.fetchShowsList(page: self.page)
                self.tvShowList.append(contentsOf: newTvShows)
                self.currentLastItem = self.tvShowList.last
                self.page += 1
#endif

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
