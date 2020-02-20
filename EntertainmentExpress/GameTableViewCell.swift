//
//  GameTableViewCell.swift
//  EntertainmentExpress
//
//  Created by epita on 19/02/2020.
//  Copyright © 2020 epita. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.layer.cornerRadius = gameImageView.frame.height / 2
        gameImageView.clipsToBounds = true
    }

    func setImage(url: String) {
        let data = try? Data(contentsOf: URL(string: url)!)
        gameImageView.image = UIImage(data: data!)
    }

}
