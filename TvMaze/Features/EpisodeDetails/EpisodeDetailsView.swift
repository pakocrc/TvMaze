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
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    CachedAsyncImage(stringUrl: viewModel.episode.image?.medium ?? "", placeholder: .wallpaper)

                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
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
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: TvMazeStore.getEpisode(),
                                                          coordinator: ShowCoordinatorView()))
}
