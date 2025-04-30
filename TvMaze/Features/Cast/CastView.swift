//
//  CastView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 23/4/25.
//

import SwiftUI

struct CastView: View {
    @StateObject var viewModel: CastViewModel

    var body: some View {
        ScrollView {
            if viewModel.cast.isEmpty {
                ContentUnavailableView("Loading...", systemImage: "arrow.down.circle.dotted", description: Text("Loading Content"))

            } else {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.cast) { cast in

                        HStack(alignment: .center) {
                            CachedAsyncImage(stringUrl: cast.character.image?.medium ?? "")
                            .frame(width: 150, alignment: .center)

                            VStack(alignment: .leading) {
                                Text(cast.character.name)
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.leading)

                                Text(cast.person.name ?? "" )
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Cast")
    }
}

#Preview {
    CastView(viewModel: CastViewModel(tvShow: TvMazeStore.getTvShow(),
                                      networkManager: NetworkManager(),
                                      coordinator: ShowCoordinatorView()))
}
