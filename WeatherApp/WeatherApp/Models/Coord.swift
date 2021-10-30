//
//  Coord.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation

class Coord: Codable {
    var lon, lat: Double?

    init(lon: Double?, lat: Double?) {
        self.lon = lon
        self.lat = lat
    }
}
