//
//  City.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation

class City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone: Int?

//    init(id: Int?, name: String?, coord: Coord?, country: String?, population: Int?, timezone: Int?) {
//        self.id = id
//        self.name = name
//        self.coord = coord
//        self.country = country
//        self.population = population
//        self.timezone = timezone
//    }
}
