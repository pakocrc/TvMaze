//
//  CastView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import SwiftUI

struct CastView: View {
    @StateObject var viewModel: CastViewModel

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: CastViewModel(tvShow: tvShow, networkManager: networkManager))
    }

    var body: some View {
        ScrollView {
            if viewModel.cast.isEmpty {
                ContentUnavailableView("Loading...", systemImage: "arrow.down.circle.dotted", description: Text("Loading Content"))

            } else {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.cast) { cast in

                        CastViewRow(cast: cast)
                            .onTapGesture {
                                viewModel.selectedPersonId = String(cast.person.id)
                            }
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("\(viewModel.tvShow.name ?? "") Cast")
        .navigationDestination(item: $viewModel.selectedPersonId) { personId in
            PersonDetailsView(personId: String(personId), networkManager: viewModel.networkManager)
        }
    }
}

#Preview {
    CastView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
}
