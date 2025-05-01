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

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowDetailsViewModel(tvShow: tvShow, networkManager: networkManager))
    }


    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CachedAsyncImage(stringUrl: viewModel.tvShow.image?.medium ?? "")
                    .frame(height: 400, alignment: .center)
                    .onTapGesture {
                        viewModel.isPresentingImageFullView.toggle()
                    }
                    .sheet(isPresented: $viewModel.isPresentingImageFullView) {
                        ImageFullView(title: viewModel.tvShow.name ?? "", imageUrl: viewModel.tvShow.image?.original ?? "")
                    }

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
                            Image(systemName: viewModel.tvShow.isFavorite || favoriteShows.contains(viewModel.tvShow) ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading) {

                        Text("Summary")
                            .font(.body)
                            .bold()

                        Text(viewModel.tvShow.summary ?? "")
                            .font(.body)
                        Divider()
                    }
                    .padding([.top, .horizontal])

                    if let days = viewModel.tvShow.schedule?.days {
                        VStack(alignment: .leading) {
                            Text("Schedule:")
                                .font(.body)
                                .bold()

                            VStack {
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

                            Divider()
                        }
                        .padding([.top, .horizontal])
                    }


                    if let genres = viewModel.tvShow.genres {
                        VStack(alignment: .leading) {
                            Text("Genres:")
                                .font(.body)
                                .bold()

                            ForEach(genres, id: \.self) { genre in
                                Text(genre.capitalized)
                                    .font(.body)
                            }

                            Divider()
                        }
                        .padding([.top, .horizontal])
                    }

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
                    .padding()

                    Divider()
                        .padding(.horizontal)

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
                    .padding()
                }

                Spacer()
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
    }

    private func addShowToFavorites() {
        if viewModel.tvShow.isFavorite {
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
}

#Preview {
    ShowDetailsView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
}
