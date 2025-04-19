//
//  TvMazeSchedule.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

struct TvMazeSchedule: Codable {
    let time: String?
    let days: [TvMazeDay]?
}
