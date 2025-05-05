//
//  TvMazeShowImage.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 2/5/25.
//

import Foundation

enum TvMazeShowImageType: String, Codable {
    case background = "background"
    case banner = "banner"
    case poster = "poster"
}

struct TvMazeShowImage: Codable, Identifiable {
    let id: Int
    let type: TvMazeShowImageType?
    let main: Bool?
    let resolutions: Resolutions?
}

// MARK: - Resolutions
struct Resolutions: Codable {
    let original: TvMazeImageInfo?
    let medium: TvMazeImageInfo?
}

// MARK: - Medium
struct TvMazeImageInfo: Codable {
    let url: String?
    let width, height: Int?
}

enum TypeEnum: String, Codable {
    case background = "background"
    case banner = "banner"
    case poster = "poster"
}
