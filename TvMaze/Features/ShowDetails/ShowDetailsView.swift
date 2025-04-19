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

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CachedAsyncImage(stringUrl: viewModel.tvShow.image?.medium)
                    .frame(height: 400, alignment: .center)

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
                        viewModel.coordinator.navigateToEpisodes(tvShow: viewModel.tvShow,
                                                                 seasons: viewModel.seasons)
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
                }

                Spacer()
            }
        }
        .navigationTitle(viewModel.tvShow.name ?? "")
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
    ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: TvMazeStore.shared.getTvShow(), coordinator: ShowCoordinatorView()))
}
