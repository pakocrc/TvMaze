//
//  FavoritesViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    let coordinator: FavoritesCoordinatorView

    init(coordinator: FavoritesCoordinatorView) {
        self.coordinator = coordinator
    }
}
