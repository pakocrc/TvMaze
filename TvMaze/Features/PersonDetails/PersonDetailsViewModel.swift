//
//  PersonDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 30/4/25.
//

import Foundation
import Combine

final class PersonDetailsViewModel: ObservableObject {
    @Published var person: TvMazePerson?
    @Published var isPresentingImageFullView = false

    let personId: String
    let networkManager: NetworkProtocol

    init(personId: String, networkManager: NetworkProtocol) {
        self.personId = personId
        self.networkManager = networkManager
    }

    @MainActor
    func fetchPersonDetails() async {
        do {
            self.person = try await networkManager.fetchPersonDetails(id: self.personId)

        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
}
