//
//  ShowDetailsView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI
import WebKit

struct ShowDetailsView: View {
    @StateObject var viewModel: ShowDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if let imageUrl = URL(string: viewModel.tvShow.image?.medium ?? "") {
                    CachedAsyncImage(url: imageUrl)
                        .frame(height: 400, alignment: .center)
                }

                VStack(alignment: .center) {

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Summary")
                                .font(.body)
                                .bold()

                            Spacer()

                            if let average = viewModel.tvShow.rating?.average {
                                Text(String(viewModel.tvShow.rating?.average ?? 0.0))
                                    .font(.body)
                                    .foregroundStyle(average < 5.0 ? .red : .green)
                                    .bold()
                            }
                        }
                        .padding(.bottom)

                        Text(viewModel.tvShow.summary ?? "")
                            .font(.body)
                        Divider()
                    }
                    .padding(.horizontal)

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
                        .padding(.horizontal)
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

                    NavigationLink {
                        ShowEpisodesView(viewModel: ShowEpisodesViewModel(tvShow: viewModel.tvShow,
                                                                          seasons: viewModel.seasons))
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
}

#Preview {
    ShowDetailsView(viewModel: ShowDetailsViewModel(tvShow: TvMazeStore.shared.getTvShow()))
}
