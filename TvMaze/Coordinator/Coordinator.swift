//
//  Coordinator.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftUI

protocol Route { }

protocol Steps: Equatable, Hashable { }

protocol Coordinator: ObservableObject {
    associatedtype CoordinatorSteps: Steps
    associatedtype CoordinatorView: View
    var path: [CoordinatorSteps] { get set }
    func redirect(_ path: CoordinatorSteps) -> CoordinatorView
}
