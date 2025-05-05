//
//  ShowImagesView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 2/5/25.
//

import SwiftUI

struct ShowImagesView: View {
    @StateObject var viewModel: ShowImagesViewModel
    @State var selectedImage: TvMazeShowImage?

    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 50.0, maximum: 150.0), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 50.0, maximum: 150.0), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 50.0, maximum: 150.0), spacing: 10, alignment: .center)
    ]

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowImagesViewModel(tvShow: tvShow, networkManager: networkManager))
    }

    var body: some View {
        ScrollView {
            if viewModel.showImages.isEmpty {
                ContentUnavailableView("Loading...", systemImage: "arrow.down.circle.dotted", description: Text("Loading Content"))

            } else {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.showImages) { image in

                        if let imageUrl = image.resolutions?.original?.url {

                            CachedAsyncImage(stringUrl: imageUrl)
                                .onTapGesture {
                                    selectedImage = image
                                }
                        }
                    }
                }
                .sheet(item: $selectedImage) { image in
                    if let imageUrl = image.resolutions?.original?.url {
                        ImageFullView(title: viewModel.tvShow.name ?? "",
                                      imageUrl: imageUrl)
                    }
                }
            }
        }
        .task {
            viewModel.fetchShowImages()
        }
    }
}

#Preview {
    ShowImagesView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
}
