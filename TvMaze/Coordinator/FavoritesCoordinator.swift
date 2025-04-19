//
//  FavoritesCoordinator.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftUI

enum FavoritesSteps: Steps {
    case favoritesList
}

extension FavoritesSteps: Identifiable, Equatable {
    var id: UUID {
        UUID()
    }

    static func == (lhs: FavoritesSteps, rhs: FavoritesSteps) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class FavoritesCoordinatorView: ObservableObject {
    @Published var path = [FavoritesSteps]()

    init() { }
}

extension FavoritesCoordinatorView: Coordinator {
    @ViewBuilder
    func redirect(_ path: FavoritesSteps) -> some View {
        switch path {
            case .favoritesList:
                FavoritesView(viewModel: FavoritesViewModel(coordinator: self))
        }
    }
}
