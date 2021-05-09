//
//  RestaurantCell.swift
//  Restaurant Recommendations
//
//  Created by Saida Hamidova on 5/3/21.
//

import UIKit

class RestaurantCell: UITableViewCell {

    // Labels
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var numberReviewsLabel: UILabel!
    
    // ImageView
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantRatingImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
