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
    @State private var isFirstTimeLoading = true

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
                await viewModel.fetchShowImages()
            }
        }
        .overlay(alignment: .top) {
            if viewModel.showImages.isEmpty {

                CustomContentUnavailableView(action: {
                    Task {
                        await viewModel.fetchShowImages()
                    }
                }, isReloadEnabled: $viewModel.isReloadEnabled)
            }
        }

    }
}

#Preview {
    ShowImagesView(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManager())
}
