//
//  TableViewController.swift
//  EntertainmentExpress
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let apiService = APIService()
    var games: [Game]?
    //var games: [Int]?
    var selectedGame: Game?
    //var selectedInt: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        apiService.fetchAllGames(completionHandler: reloadTable(games:))
        //games = [1,2,3,4,5,6]
    }
    
    func reloadTable(games: [Game]) {
        self.games = games
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        detailViewController.game = selectedGame
        //detailViewController.testInt = selectedInt
    }

}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return games?.count ?? 0
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell else {
            //print("inside cell")
            return UITableViewCell()
        }
        
        guard let game = games?[indexPath.row] else {
            //print("inside games")
            if(indexPath.row % 2 == 0) {
                cell.backgroundColor = UIColor.lightGray
            }
            return UITableViewCell()
        }
        //assign values to cell views
        
        cell.titleLabel.text = game.name
        cell.yearLabel.text = game.released
        cell.ratingsLabel.text = String(game.rating) + "/5"
        cell.setImage(url: game.background_image)
        
        //cell.titleLabel.text = "name"
        //cell.yearLabel.text = "game.released"
        //cell.ratingsLabel.text = "/10"
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let games = games else {
            return indexPath
        }
        
        selectedGame = games[indexPath.row]
        //selectedInt = games[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

