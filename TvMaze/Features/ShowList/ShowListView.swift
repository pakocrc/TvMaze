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
            LazyVStack {
                if viewModel.isSearching {
                    ForEach(viewModel.searchTvShowList) { show in
                        NavigationLink(value: show) {
                            ShowRowView(show: show)
                                .frame(height: 200, alignment: .center)
                                .task {
                                    if show == viewModel.currentLastItem {
                                        Task {
                                            viewModel.fetchShowsList()
                                        }
                                    }
                                }
                        }
                        .foregroundStyle(.primary)

                        Divider()
                            .padding(.horizontal)
                    }

                } else {
                    ForEach(viewModel.tvShowList) { show in
                        NavigationLink(value: show) {
                            ShowRowView(show: show)
                                .frame(height: 200, alignment: .center)
                                .task {
                                    if show == viewModel.currentLastItem {
                                        Task {
                                            viewModel.fetchShowsList()
                                        }
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
        .searchPresentationToolbarBehavior(.automatic)
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .searchable(text: $viewModel.searchCriteria,
                    isPresented: $viewModel.isSearching)
        .navigationTitle("TvMaze")
        .navigationDestination(for: TvMazeShow.self) { show in
            ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: show))
        }
    }
}

#Preview {
    ShowListView(viewModel: ShowListViewModel())
}
