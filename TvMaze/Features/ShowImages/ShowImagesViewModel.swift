//
//  ShowImagesViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 2/5/25.
//

import Foundation

final class ShowImagesViewModel: ObservableObject {
    @Published var showImages: [TvMazeShowImage] = []

    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager
    }

    @MainActor
    func fetchShowImages() {
        debugPrint("On fetchShowImages()")
        Task {
            do {
                self.showImages = try await networkManager.fetchShowImages(showId: self.tvShow.id)
            } catch let error {
                debugPrint("❌ Error:", error.localizedDescription)
            }
        }
    }
}
