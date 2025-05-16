//
//  CastViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 15/5/25.
//

import XCTest
@testable import TvMaze

final class CastViewModelTests: XCTestCase {

    func testFetchCastSuccessful() async throws {
        // given
        let sut = CastViewModel(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManagerMock())

        // when
        await sut.fetchCast()

        // then
        XCTAssertTrue(sut.cast.count > 0)
    }

    func testFetchCastFail() async throws {
        // given
        let sut = CastViewModel(tvShow: TvMazeShow(id: "fail", url: nil, name: nil, type: nil, language: nil, genres: nil, status: nil, runtime: nil, averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: nil, rating: nil, weight: nil, image: nil, updated: nil), networkManager: NetworkManagerMock())

        // when
        await sut.fetchCast()

        // then
        XCTAssertTrue(sut.cast.count == 0)
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }
}
