//
//  ShowDetailsView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI
import SwiftData

struct ShowDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteShows: [TvMazeShow]

    @StateObject var viewModel: ShowDetailsViewModel
    @State private var isFirstTimeLoading = true

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowDetailsViewModel(tvShow: tvShow, networkManager: networkManager))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                CachedAsyncImage(stringUrl: viewModel.tvShow.image?.medium ?? "")
                    .frame(height: 400, alignment: .center) 
                    .onTapGesture {
                        viewModel.isPresentingImageFullView.toggle()
                    }
                    .sheet(isPresented: $viewModel.isPresentingImageFullView) {
                        ImageFullView(title: viewModel.tvShow.name ?? "", imageUrl: viewModel.tvShow.image?.original ?? "")
                    }

                Divider()
                    .padding(.horizontal)

                VStack(alignment: .center) {
                    HStack {
                        if let average = viewModel.tvShow.rating?.average {
                            Text("Rating:")
                                .font(.body)
                                .bold()

                            Text(String(average))
                                .font(.body)
                                .foregroundStyle(average < 5.0 ? .red : .green)
                                .bold()
                        }

                        Spacer()

                        Button {
                            addShowToFavorites()
                        } label: {
                            Image(systemName: isFavoriteShow() ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading) {
                        Divider()
                        Text("Summary")
                            .font(.body)
                            .bold()

                        Text(viewModel.tvShow.summary ?? "")
                            .font(.body)
                    }
                    .padding([.top, .horizontal])

                    if let days = viewModel.tvShow.schedule?.days {
                        VStack(alignment: .leading) {
                            Divider()

                            Text("Schedule:")
                                .font(.body)
                                .bold()

                            VStack(alignment: .leading) {
                                ForEach(days) { day in
                                    HStack {
                                        Text(day.rawValue)
                                            .font(.body)

                                        if let time = viewModel.tvShow.schedule?.time {
                                            Text(" - ")
                                                .font(.body)

                                            Text(time)
                                                .font(.body)
                                        }
                                    }
                                }
                            }
                        }
                        .padding([.top, .horizontal])
                    }


                    if let genres = viewModel.tvShow.genres {
                        VStack(alignment: .leading) {
                            Divider()
                            Text("Genres:")
                                .font(.body)
                                .bold()

                            Text(formatGenres(genres))
                                .font(.body)
                        }
                        .padding()
                    }

                    VStack {
                        Divider()

                        Button {
                            viewModel.presentShowEpisodes.toggle()
                        } label: {
                            HStack {
                                Text("Seasons")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    .padding()

                    VStack {
                        Divider()

                        Button {
                            viewModel.presentShowCast.toggle()
                        } label: {
                            HStack {
                                Text("Cast")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    .padding()

                    VStack {
                        Divider()

                        Button {
                            viewModel.presentShowImages.toggle()
                        } label: {
                            HStack {
                                Text("Images")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(viewModel.tvShow.name ?? "")
        .navigationDestination(isPresented: $viewModel.presentShowEpisodes) {
            ShowEpisodesView(tvShow: viewModel.tvShow,
                             seasons: viewModel.seasons,
                             networkManager: viewModel.networkManager)
        }
        .navigationDestination(isPresented: $viewModel.presentShowCast) {
            CastView(tvShow: viewModel.tvShow, networkManager: viewModel.networkManager)
        }
        .navigationDestination(isPresented: $viewModel.presentShowImages) {
            ShowImagesView(tvShow: viewModel.tvShow, networkManager: viewModel.networkManager)
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
                await viewModel.fetchEpisodeList()
            }
        }
    }

    private func addShowToFavorites() {
        if viewModel.tvShow.isFavorite || favoriteShows.contains(viewModel.tvShow) {
            modelContext.delete(viewModel.tvShow)
        } else {
            modelContext.insert(viewModel.tvShow)
        }

        do {
            try modelContext.save()
        } catch {
            debugPrint("Error storing object: \(error)")
        }

        viewModel.tvShow.setFavorite()
    }

    private func isFavoriteShow() -> Bool {

        if viewModel.tvShow.isFavorite || favoriteShows.contains(viewModel.tvShow) {
            return true
        }

        return false
    }

    private func formatGenres(_ genres: [String]) -> String {
        return genres.reduce("") { partialResult, genre in
            return partialResult + genre.capitalized + (genre == viewModel.tvShow.genres?.last ? "." : ", ")
        }
    }
}

#Preview {
    ShowDetailsView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
//        .modelContainer(for: TvMazeShow.self, inMemory: true)
}
