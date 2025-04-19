//
//  EpisodeDetailsView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @StateObject var viewModel: EpisodeDetailsViewModel

    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = URL(string: viewModel.episode.image?.medium ?? "") {
                    CachedAsyncImage(url: imageUrl)
                        .frame(height: 300, alignment: .center)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text("\(viewModel.episode.number ?? 0).")
                        Text(viewModel.episode.name ?? "")
                    }
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    HStack {
                        Text("Season:")
                            .font(.body)
                            .bold()
                        Text("\(viewModel.episode.season ?? 0)")
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    VStack(alignment: .leading) {
                        Text("Summary")
                            .font(.body)
                            .bold()

                        Text(viewModel.episode.summary ?? "N/A")
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: TvMazeEpisode(id: 1954, url: Optional("https://www.tvmaze.com/episodes/1954/outlander-1x01-sassenach"), name: Optional("Sassenach"), season: Optional(1), number: Optional(1), type: Optional("regular"), airdate: Optional("2014-08-09"), airtime: Optional("21:00"), airstamp: Optional("2014-08-10T01:00:00+00:00"), runtime: Optional(60), rating: Optional(TvMaze.TvMazeRating(average: Optional(7.5))), image: Optional(TvMaze.TvMazeImage(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/54/135755.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/54/135755.jpg")), summary: Optional("<p>While on her second honeymoon, WWII combat nurse Claire Randall is mysteriously transported back to 1743 Scotland, where she is kidnapped by a group of Highlanders - and meets an injured young man named Jamie.</p>")), coordinator: ShowCoordinatorView()))
}
