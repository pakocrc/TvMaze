//
//  TvMazeNetwork.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftData

@Model
final class TvMazeNetwork: Codable {
    var id: Int?
    var name: String?
    var country: TvMazeCountry?
    var officialSite: String?
    
    init(id: Int?, name: String?, country: TvMazeCountry?, officialSite: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.officialSite = officialSite
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        country = try container.decodeIfPresent(TvMazeCountry.self, forKey: .country)
        officialSite = try container.decodeIfPresent(String.self, forKey: .officialSite)
    }
    
    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(officialSite, forKey: .officialSite)
    }
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case officialSite
    }
}
