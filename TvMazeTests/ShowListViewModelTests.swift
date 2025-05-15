//
//  ShowListViewModelTests.swift
//  TvMazeTests
//
//  Created by Francisco Cordoba on 14/5/25.
//

import Testing
import XCTest
@testable import TvMaze

final class ShowListViewModelTests: XCTestCase {
    var sut: ShowListViewModel!

    override func setUp() async throws {
        await MainActor.run {
            self.sut = ShowListViewModel(networkManager: NetworkManagerMock())
        }
    }

    @MainActor
    func testFetchTvShowListSuccessful() async throws {
        // given

        // when
        await sut.fetchShowsList()

        // then
        XCTAssertTrue(sut.tvShowList.count > 0)
    }

    @MainActor
    func testFetchTvShowListFail() async throws {
        // given

        // when
        await sut.fetchShowsList()
        await sut.fetchShowsList()

        // then
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }

    @MainActor
    func testSearchTvShows() async throws {
        // given

        // when
        sut.isSearching = true
        sut.searchCriteria = "outl"
        sut.searchCriteria = "outlan"
        sut.searchCriteria = "outlander"

        sleep(1)
        await sut.searchShow(searchCriteria: "outl")

        // then
        XCTAssertTrue(sut.searchTvShowList.count > 0)
    }

    @MainActor
    func testSearchTvShowsFail() async throws {
        // given

        // when
        await sut.searchShow(searchCriteria: "fail")

        // then
        XCTAssertTrue(sut.displayAlert)
        XCTAssertTrue(!sut.alertMessage.isEmpty)
    }

    @MainActor
    func testIsSearchingTvShows() async throws {
        // given

        // when
        sut.isSearching = true
        sut.searchCriteria = "outl"
        sut.searchCriteria = "outlan"
        sut.searchCriteria = ""
        sut.isSearching = false
        sleep(1)

        // then
        XCTAssertTrue(sut.searchTvShowList.count == 0)
    }

    @MainActor
    func testRefreshTvShows() async throws {
        // given

        // when
        await sut.refreshShowsList()

        // then
        XCTAssertTrue(sut.tvShowList.count > 0)
    }
}

struct ShowListViewModelTests2 {

    @MainActor @Test
    func fetchTvShowList() async throws {
        // given
        let sut = ShowListViewModel(networkManager: NetworkManagerMock())

        // when
        await sut.fetchShowsList()

        // then
        #expect(!sut.tvShowList.isEmpty)
    }
}
