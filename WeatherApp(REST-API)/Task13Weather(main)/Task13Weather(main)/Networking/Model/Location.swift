//
//  Location.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import Foundation

struct Location: Codable {
    var id: Int
    var name: String
    var type: String
    var coordinates: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case type = "location_type"
        case id = "woeid"
        case coordinates = "latt_long"
    }
}

