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
    
    
    
    var chosenRestaurant: Restaurant?
    let fire = FirebaseHelper()
    
    
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
