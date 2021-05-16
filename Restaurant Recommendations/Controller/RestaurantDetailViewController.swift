//
//  RestaurantDetailViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit
import Firebase

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var typeOfFoodlabel: UILabel!
    @IBOutlet weak var dollarSignLabel: UILabel!
    
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var totalAmountOfReviewsLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var streetCityLabel: UILabel!
    @IBOutlet weak var stateZipCodeLabel: UILabel!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    
    var chosenRestaurant: Restaurant?
    let fire = FirebaseHelper()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        restaurantNameLabel.text = chosenRestaurant?.restaurantName
        typeOfFoodlabel.text = chosenRestaurant?.restaurantAlias
        dollarSignLabel.text = "$"

        // Formatted phone-number string using a Swift extension.
        phoneNumberLabel.text = chosenRestaurant?.restaurantPhoneNumber.toPhoneNumber()
    
        
        
        
        switch chosenRestaurant?.restaurantRating {
        case 0.0:
            starImageView.image = UIImage(named: "extra_large_0")
        case 1.0:
            starImageView.image = UIImage(named: "extra_large_1")
        case 1.5:
            starImageView.image = UIImage(named: "extra_large_1_half")
        case 2.0:
            starImageView.image = UIImage(named: "extra_large_2")
        case 2.5:
            starImageView.image = UIImage(named: "extra_large_2_half")
        case 3.0:
            starImageView.image = UIImage(named: "extra_large_3")
        case 3.5:
            starImageView.image = UIImage(named: "extra_large_3_half")
        case 4.0:
            starImageView.image = UIImage(named: "extra_large_4")
        case 4.5:
            starImageView.image = UIImage(named: "extra_large_4_half")
        case 5.0:
            starImageView.image = UIImage(named: "extra_large_5")
        default:
            starImageView.image = UIImage(named: "extra_large_0")
        }
        
        if let chosen = chosenRestaurant {
            setImageView(theImageURL: chosen.restaurantImage_url)
            
        }

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
                                self.restaurantImageView.image = unwrappedImage
                                
                            }
                            
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fire.delegate = self
    }
    
    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
    
        if let id = chosenRestaurant?.restaurantID {
            fire.addFavoriteRestaurant(theID: id)
        }
    }
    
}

extension RestaurantDetailViewController: firebaseProtocols {
    
    func restaurantAdded() {
        
        navigationController?.popToRootViewController(animated: true)
        
        
        
    }
    func error(error: Error) {
        
        print(error.localizedDescription)
        
    }
    
    func signUpSuccessful() {}
    func signInSuccessful() {}
    func signedOutSuccessful() {}
    func friendAdded() {}
    func profilePictureUploaded() {}
    
}

// Adjusted code snippet is from stackoverflow.com/questions/14974331/string-to-phone-number-format-on-ios
extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1 ($2) $3-$4", options: .regularExpression, range: nil)
    }
}


