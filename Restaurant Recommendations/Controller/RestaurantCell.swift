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

        
    }

    func setImageView (theImageURL: String){
        
        if let url = URL(string: theImageURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                
                if let e = error {
                    print("Could not convert url to a image: \(e.localizedDescription)")
                    
                    //Can also call the error delegate here
                    
                    
                    
                    
                }
                else {
                    
                    if let imageData = data {
                        let tempImage = UIImage(data: imageData)
                        
                        if let unwrappedImage = tempImage {
                            
                            
                            DispatchQueue.main.async {
                                self.restaurantImage.image = unwrappedImage
                                

                                /*
                                 Inside here set the imageView to the unwrapped image from the url
                                 Something like:
                                 self.profilePictureImageView.image = unwrappedImage
                                 
                                 
                                 */
                                
                                
                                
                            }
                            
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .white
    }
    
}
