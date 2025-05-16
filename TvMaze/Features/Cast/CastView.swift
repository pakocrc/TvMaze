//
//  CastView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import SwiftUI

struct CastView: View {
    @StateObject var viewModel: CastViewModel
    @State private var isFirstTimeLoading = true

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: CastViewModel(tvShow: tvShow, networkManager: networkManager))
    }

    var body: some View {
        ScrollView {
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
        .navigationTitle("\(viewModel.tvShow.name ?? "") Cast")
        .navigationDestination(item: $viewModel.selectedPersonId) { personId in
            PersonDetailsView(personId: String(personId), networkManager: viewModel.networkManager)
        }
        .alert("Alert", isPresented: $viewModel.displayAlert, actions: {
            Button("Close", role: .cancel) {
                viewModel.displayAlert.toggle()
            }
        }, message: {
            Text(viewModel.alertMessage)
        })
        .task {
            if isFirstTimeLoading {
                isFirstTimeLoading.toggle()
                await viewModel.fetchCast()
            }
        }
        .overlay(alignment: .top) {
            if viewModel.cast.isEmpty {

                ContentUnavailableView {
                    Label("Loading", systemImage: "arrow.down.circle.dotted")

                } description: {
                    Text("Retrieving information...")

                } actions: {
                    if viewModel.isReloadEnabled {
                        Button {
                            Task {
                                await viewModel.fetchCast()
                            }
                        } label: {
                            Text("Reload")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CastView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
}
