//
//  ShowImagesViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 15/5/25.
//

import XCTest
@testable import TvMaze

final class ShowImagesViewModelTests: XCTestCase {

    func testFetchShowImagesSuccessful() async throws {
        // given
        let sut = ShowImagesViewModel(tvShow: TvMazeStore.getTvShow(), networkManager: NetworkManagerMock())

        // when
        await sut.fetchShowImages()

        // then
        XCTAssertTrue(sut.showImages.count > 0)
    }

    func testFetchShowImagesFail() async throws {
        // given
        let sut = ShowImagesViewModel(tvShow: TvMazeShow(id: "fail", url: nil, name: nil, type: nil, language: nil, genres: nil, status: nil, runtime: nil, averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: nil, rating: nil, weight: nil, image: nil, updated: nil), networkManager: NetworkManagerMock())

        // when
        await sut.fetchShowImages()

        // then
        XCTAssertTrue(sut.showImages.count == 0)
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }
}
