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
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var altNameLabels: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = game?.id else {
            return
        }
        apiService.fetchGameDetail(id: id, completionHandler: reloadViews(game:))
        populateDetails()

    }
    
    func reloadViews(game: GameDetail) {
        self.gameDetail = game
        DispatchQueue.main.async {
            self.populateDetails()
        }
    }
    
    func populateDetails() {
        guard let gameDetail = gameDetail else {
            return
        }
        
        if(gameDetail.background_image_additional == "") {
            guard let game = game else {
                return
            }
            let data = try? Data(contentsOf: URL(string: game.background_image)!)
            gameImageView.image = UIImage(data: data!)
        } else {
            let data = try? Data(contentsOf: URL(string: gameDetail.background_image_additional)!)
            gameImageView.image = UIImage(data: data!)
        }
        
        var original = ""
        if(gameDetail.name_original != "") {
            original = " (" + gameDetail.name_original + ")"
        }
        
        titleLabel.text = gameDetail.name + original
        
        if(gameDetail.alternative_names.count != 0 && gameDetail.alternative_names != nil) {
            var altNames = "Also known as: "
            for name in gameDetail.alternative_names {
                altNames += name + "   "
            }
            altNameLabels.text = altNames
        } else {
            altNameLabels.text = ""
        }
        
        let descNoHTML = gameDetail.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let descClean = descNoHTML.replacingOccurrences(of: "&#39;", with: "'", options: .regularExpression, range: nil)
        descLabel.text = descClean
        
        urlLabel.text = "Find out more at\n" + gameDetail.website
        
        
    }

}
