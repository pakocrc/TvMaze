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
    @Published var refreshItem: TvMazeShow?
    @Published var searchCriteria: String = ""
    @Published var isSearching = false
    @Published var selectedTvShow: TvMazeShow?

    private var isLoading = false
    private var page = 0
    private var cancellables = Set<AnyCancellable>()

    let networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager

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

        $tvShowList
            .sink { shows in
                print("Shows count:", shows.count)
            }.store(in: &cancellables)
    }

    @MainActor
    func searchShow(searchCriteria: String) {
        Task {
            do {
                isLoading = true
                let searchTvMazeShowResult = try await networkManager.searchTvShow(searchCriteria: searchCriteria)
                self.searchTvShowList = searchTvMazeShowResult.map({ $0.show })
                isLoading = false

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    @MainActor
    func fetchShowsList() async {
        if !isLoading {
            do {
                isLoading = true
                let newTvShows = try await networkManager.fetchShowsList(page: page)
                tvShowList.append(contentsOf: newTvShows)
                refreshItem = tvShowList.last
                page += 1
                isLoading = false

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    @MainActor
    func refreshShowsList() async {
        page = 0
        tvShowList.removeAll()
        await fetchShowsList()
    }
}
