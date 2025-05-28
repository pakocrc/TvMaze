//
//  ShowListView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct ShowListView: View {
    @StateObject var viewModel: ShowListViewModel
    @State private var isFirstTimeLoading = true

    init(networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowListViewModel(networkManager: networkManager))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if viewModel.isSearching {
                        ForEach(viewModel.searchTvShowList) { show in
                            Button {
                                viewModel.selectedTvShow = show
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
                                viewModel.selectedTvShow = show
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
            .refreshable(action: { await viewModel.refreshShowsList() })
            .searchPresentationToolbarBehavior(.automatic)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .searchable(text: $viewModel.searchCriteria,
                        isPresented: $viewModel.isSearching)
            .navigationDestination(item: $viewModel.selectedTvShow) { tvShow in
                ShowDetailsView(tvShow: tvShow, networkManager: viewModel.networkManager)
            }
            .navigationTitle("TvMaze")
            .task {
                if isFirstTimeLoading {
                    isFirstTimeLoading.toggle()
                    await viewModel.fetchShowsList()
                }
            }
            .alert("Alert", isPresented: $viewModel.displayAlert, actions: {
                Button("Close", role: .cancel) {
                    viewModel.displayAlert.toggle()
                }
            }, message: {
                Text(viewModel.alertMessage)
            })
            .overlay(alignment: .top) {

                if viewModel.tvShowList.isEmpty {
                    CustomContentUnavailableView(action: {
                        Task {
                            await viewModel.fetchShowsList()
                        }
                    }, isReloadEnabled: $viewModel.isReloadEnabled)

                } else if viewModel.searchTvShowList.isEmpty && viewModel.isSearching {
                    ContentUnavailableView.search

                }
            }
        }
    }
}

#Preview {
    ShowListView(networkManager: NetworkManager())
}
