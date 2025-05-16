//
//  ShowImagesViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 2/5/25.
//

import Foundation

final class ShowImagesViewModel: ObservableObject {
    @Published var showImages: [TvMazeShowImage] = []
    @Published var displayAlert = false
    @Published var alertMessage = ""
    @Published var isReloadEnabled = false

    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchShowImages() async {
        do {
            showImages = try await networkManager.fetchShowImages(showId: tvShow.id)

        } catch let error {
            debugPrint(error.localizedDescription)
            displayAlert.toggle()
            isReloadEnabled = true
            alertMessage = error.localizedDescription
        }
    }
}
