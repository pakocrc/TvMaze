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
    @Published var displayAlert = false
    @Published var alertMessage = ""
    @Published var isReloadEnabled = false

    private var isLoading = false
    private var page = 0
    private var cancellables = Set<AnyCancellable>()

    let networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        bindPublishers()
    }

    private func bindPublishers() {
        $searchCriteria
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .filter({ $0.count > 3 })
            .sink(receiveValue: { [weak self] searchCriteria in

                Task {
                    await self?.searchShow(searchCriteria: searchCriteria)
                }
            }).store(in: &cancellables)

        $isSearching
            .dropFirst()
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { [weak self] isSearching in

                if !isSearching {
                    self?.searchTvShowList.removeAll()
                }
            }.store(in: &cancellables)

//        $tvShowList
//            .sink { shows in
//                print("Shows count:", shows.count)
//            }.store(in: &cancellables)
    }

    @MainActor
    func searchShow(searchCriteria: String) async {
        do {
            isLoading = true
            let searchTvMazeShowResult = try await networkManager.searchTvShow(searchCriteria: searchCriteria)
            searchTvShowList = searchTvMazeShowResult.map({ $0.show })
            isLoading = false

        } catch let error {
            debugPrint(error.localizedDescription)
            displayAlert.toggle()
            isReloadEnabled.toggle()
            alertMessage = error.localizedDescription
        }
    }

    @MainActor
    func fetchShowsList() async {

        if !isLoading {
            do {
                isLoading = true
                try await tvShowList.append(contentsOf: networkManager.fetchShowsList(page: page))
                refreshItem = tvShowList.last
                page += 1
                isLoading = false

            } catch let error {
                debugPrint(error.localizedDescription)
                displayAlert.toggle()
                isReloadEnabled = true
                isLoading = false
                alertMessage = error.localizedDescription
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
