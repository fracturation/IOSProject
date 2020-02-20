//
//  DetailViewController.swift
//  EntertainmentExpress
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var game: Game?
    //var testInt: Int?
    var gameDetail: GameDetail?
    let apiService = APIService()
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var altNameLabels: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = game?.id else {
            return
        }
        apiService.fetchGameDetail(id: id, completionHandler: reloadViews(game:))
        populateDetails()
        //if(testInt != nil) {
        //    titleLabel.text = String(testInt!)
        //} else {
        //    titleLabel.text = "12"
        //}
        //titleLabel.text = "12"
    }
    
    func reloadViews(game: GameDetail) {
        self.gameDetail = game
        DispatchQueue.main.async {
            //need to do something here?
        }
    }
    
    func populateDetails() {
        guard let game = gameDetail else {
            return
        }
        
        let data = try? Data(contentsOf: URL(string: game.background_image_additional)!)
        gameImageView.image = UIImage(data: data!)
        titleLabel.text = game.name
        
        if(game.alternative_names.count != 0) {
            var altNames = "Also known as: "
            for name in game.alternative_names {
                altNames += name + " | "
            }
        }
        
        descLabel.text = game.description
        urlLabel.text = "For more information visit\n" + game.website
        
        
    }

}
