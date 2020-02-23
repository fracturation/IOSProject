//
//  GameDetail.swift
//  EntertainmentExpress
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import Foundation

class GameDetail: Codable {
    let id: Int
    let name: String
    let name_original: String
    let description: String
    let background_image_additional: String
    let website: String
    let alternative_names: [String]
}
