//
//  ShowListViewTests.swift
//  TvMazeUITests
//
//  Created by Francisco Cordoba on 28/5/25.
//

import XCTest
@testable import TvMaze

final class ShowListViewTests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testShowListViewScrollView() throws {
        let scrollView = app.scrollViews["showListViewScrollView"]
        XCTAssertTrue(scrollView.exists)
    }
}
