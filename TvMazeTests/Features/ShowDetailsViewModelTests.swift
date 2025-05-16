//
//  ShowDetailsViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 14/5/25.
//

import XCTest
@testable import TvMaze

final class ShowDetailsViewModelTests: XCTestCase {
    @MainActor
    func testFetchSeasonsSuccessful() async throws {
        // given
        let sut = ShowDetailsViewModel(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManagerMock())
        // when
        await sut.fetchEpisodeList()

        // then
        XCTAssertTrue(sut.seasons.count > 0)
    }

    @MainActor
    func testFetchSeasonsFail() async throws {
        // given
        let sut = ShowDetailsViewModel(tvShow: TvMazeShow(id: "fail", url: nil, name: nil, type: nil, language: nil, genres: nil, status: nil, runtime: nil, averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: nil, rating: nil, weight: nil, image: nil, updated: nil), networkManager: NetworkManagerMock())

        // when
        await sut.fetchEpisodeList()

        // then
        XCTAssertTrue(sut.seasons.count == 0)
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }
}
