//
//  Species.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import Foundation

struct Species: Identifiable, Codable, Hashable {
    let id = UUID().uuidString

    var name: String
    var classification: String
    var designation: String
    var average_height: String
    var average_lifespan: String
    var language: String
    var skin_colors: String
    var hair_colors: String
    var eye_colors: String
    var url: String

    enum CodingKeys: CodingKey {
        case name, classification, designation, average_height, average_lifespan, language, skin_colors, hair_colors, eye_colors, url
    }
}
