//
//  APIService.swift
//  EntertainmentExpress
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import Foundation

class APIService {
    let baseURL: String = "https://api.rawg.io/api"
    let userAgent: String = "Entertainment Express"
    
    func fetchAllGames(completionHandler: @escaping ([Game]) -> Void) {
        guard let url = URL(string: baseURL + "/games?page_size=10") else {
            return
        }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["User-Agent": userAgent]
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data, let gameResults = try? JSONDecoder().decode(GameResult.self, from: data) {
                let array = gameResults.results
                completionHandler(array)
            }
        })
        task.resume()
        
        
    }
    
    func fetchGameDetail(id: Int, completionHandler: @escaping (GameDetail) -> Void) {
        guard let url = URL(string: baseURL + "/games/" + String(id)) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data, let gameDetailResult = try? JSONDecoder().decode(GameDetail.self, from: data) {
                let gameDetail = gameDetailResult
                completionHandler(gameDetail)
            }
        })
        
        task.resume()
    }
}
