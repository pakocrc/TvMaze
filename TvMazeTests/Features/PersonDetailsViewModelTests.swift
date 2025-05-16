//
//  PersonDetailsViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 15/5/25.
//

import XCTest
@testable import TvMaze

final class PersonDetailsViewModelTests: XCTestCase {

    func testFetchPersonDetailsSuccessful() async throws {
        // given
        let sut = PersonDetailsViewModel(personId: "6662", networkManager: NetworkManagerMock())

        // when
        await sut.fetchPersonDetails()

        // then
        XCTAssertTrue(sut.person != nil)
    }

    func testFetchPersonDetailsFail() async throws {
        // given
        let sut = PersonDetailsViewModel(personId: "fail", networkManager: NetworkManagerMock())

        // when
        await sut.fetchPersonDetails()

        // then
        XCTAssertTrue(sut.person == nil)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
        XCTAssertTrue(sut.displayAlert)
    }
}
