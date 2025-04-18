//
//  ShowListView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct ShowListView: View {
    @StateObject var viewModel: ShowListViewModel
    @State var searchText: String = ""

    var body: some View {
        ScrollView {
            LazyVStack {
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
        .searchPresentationToolbarBehavior(.automatic)
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .searchable(text: $searchText)
        .navigationTitle("TvMaze")
        .navigationDestination(for: TvShow.self) { show in
            ShowDetailsView(show: show)
        }
    }
}

#Preview {
    ShowListView(viewModel: ShowListViewModel())
}
