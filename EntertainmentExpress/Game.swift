//
//  Game.swift
//  HydraMovies
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import Foundation

class GameResult: Codable {
    //let count: Int
    //let next: String
    //let previous: String
    let results: [Game]
}

class Game: Codable {
    let id: Int
    //let slug: String
    let name: String
    let released: String
    //let tba: Bool
    let background_image: String
    let rating: Double
    //let playtime: Int
}
