//
//  EpisodeDetailsView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: TvMazeEpisode
    @State var isPresentingImageFullView = false

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    CachedAsyncImage(stringUrl: episode.image?.medium ?? "", placeholder: .wallpaper)
                        .frame(width: proxy.size.width, height: proxy.size.height / 2, alignment: .center)
                        .onTapGesture {
                            isPresentingImageFullView.toggle()
                        }
                        .sheet(isPresented: $isPresentingImageFullView) {
                            ImageFullView(title: episode.name ?? "",
                                          imageUrl: episode.image?.original ?? "")
                        }

                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(episode.number ?? 0).")
                            Text(episode.name ?? "")
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
                            Text("\(episode.season ?? 0)")
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text("Summary")
                                .font(.body)
                                .bold()
                            
                            Text(episode.summary ?? "N/A")
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
    EpisodeDetailsView(episode: TvMazeStore.getEpisode())
}
