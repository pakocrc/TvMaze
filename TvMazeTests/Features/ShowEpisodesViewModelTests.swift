//
//  ShowEpisodesViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 15/5/25.
//

import XCTest
@testable import TvMaze

final class ShowEpisodesViewModelTests: XCTestCase {

    func testFetchEpisodeListSuccessful() async throws {
        // given
        let sut = ShowEpisodesViewModel(tvShow: TvMazeStore.getTvShow(), seasons: TvMazeStore.getSeasons(), networkManager: NetworkManagerMock())

        // when
        await sut.fetchEpisodeList()

        // then
        XCTAssertTrue(sut.seasonEpisodes.count > 0)
    }

    func testFetchEpisodeListFail() async throws {
        // given
        let sut = ShowEpisodesViewModel(tvShow: TvMazeShow(id: "fail", url: nil, name: nil, type: nil, language: nil, genres: nil, status: nil, runtime: nil, averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: nil, rating: nil, weight: nil, image: nil, updated: nil), seasons: TvMazeStore.getSeasons(), networkManager: NetworkManagerMock())

        // when
        await sut.fetchEpisodeList()

        // then
        XCTAssertTrue(sut.seasonEpisodes.count == 0)
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }

//    func testFetchEpisodesListPerformance() async throws {
//        self.measure {
//            Task {
//                // given
//                let sut = ShowEpisodesViewModel(tvShow: TvMazeStore.getTvShow(), seasons: TvMazeStore.getSeasons(), networkManager: NetworkManagerMock())
//
//                // when
//                await sut.fetchEpisodeList()
//
//                self.stopMeasuring()
//            }
//        }
//    }
}
