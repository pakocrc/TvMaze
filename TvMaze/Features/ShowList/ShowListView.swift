//
//  ShowListView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct ShowListView: View {
    @StateObject var viewModel: ShowListViewModel

    var body: some View {
        ScrollView {
            if viewModel.tvShowList.isEmpty {
                ContentUnavailableView("Loading", systemImage: "arrow.down.circle.dotted", description: Text("Fetching shows data..."))
            } else {
                LazyVStack {
                    if viewModel.isSearching {
                        ForEach(viewModel.searchTvShowList) { show in
                            Button {
                                viewModel.coordinator.navigateToDetail(tvShow: show)
                            } label: {
                                ShowRowView(show: show)
                                    .frame(height: 200, alignment: .center)
                            }
                            .foregroundStyle(.primary)

                            Divider()
                                .padding(.horizontal)
                        }

                    } else {
                        ForEach(viewModel.tvShowList) { show in
                            Button {
                                viewModel.coordinator.navigateToDetail(tvShow: show)
                            } label: {
                                ShowRowView(show: show)
                                    .frame(height: 200, alignment: .center)
                                    .task {
                                        if show == viewModel.refreshItem {
                                            await viewModel.fetchShowsList()
                                        }
                                    }
                            }
                            .foregroundStyle(.primary)

                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .refreshable(action: { await viewModel.refreshShowsList() })
        .searchPresentationToolbarBehavior(.automatic)
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .searchable(text: $viewModel.searchCriteria,
                    isPresented: $viewModel.isSearching)
        .navigationTitle("TvMaze")
        .applyNavigation(coordinator: viewModel.coordinator)
    }
}

#Preview {
    ShowListView(viewModel: ShowListViewModel(networkManager: NetworkManager(),
                                              coordinator: ShowCoordinatorView()))
}
