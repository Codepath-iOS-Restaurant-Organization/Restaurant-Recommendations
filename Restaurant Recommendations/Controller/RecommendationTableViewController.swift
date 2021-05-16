//
//  RecommendationTableViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit
import Firebase

class RecommendationTableViewController: UITableViewController
{
    var friendChosen = ""
    var currentUser = UserInformation()
    var friend = UserInformation()
    var search = Search()
    
    //similar/different array
    var similarArray = [Restaurant]()
    var differentArray = [Restaurant]()
    var globalCounter = 0
    var globalIndex = 0
    
    var chosenRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.userDelegate = self
        friend.userDelegate = self
        search.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        if let current = Auth.auth().currentUser?.email
        {
            currentUser.getUserRestaurants(email: current)
            friend.getUserRestaurants(email: friendChosen)
        }
    }

    //return number of sections in table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        //returns 2 section (recommendation and other)
        return 2
    }

    //return number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0
        {
            return similarArray.count
        }
        if section == 1
        {
            return differentArray.count
        }
        
        return 0
    }
    
    //color recommendated cell green
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        

        if (indexPath.section == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            
            cell.restaurantNameLabel.text = similarArray[indexPath.row].restaurantName
            cell.phoneNumberLabel.text = similarArray[indexPath.row].restaurantPhoneNumber.toPhoneNumber()
            cell.categoryLabel.text = similarArray[indexPath.row].restaurantAlias
            cell.numberReviewsLabel.text = String(similarArray[indexPath.row].restaurantReview_count)
            cell.setImageView(theImageURL: similarArray[indexPath.row].restaurantImage_url)

            switch similarArray[indexPath.row].restaurantRating {
            case 0.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
            case 1.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_1")
            case 1.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_1_half")
            case 2.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_2")
            case 2.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_2_half")
            case 3.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_3")
            case 3.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_3_half")
            case 4.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_4")
            case 4.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_4_half")
            case 5.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_5")
            default:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
            }
                
            return cell
        
            
            
        }
        else if (indexPath.section == 1)
        {
            
            cell.restaurantNameLabel.text = differentArray[indexPath.row].restaurantName
            cell.phoneNumberLabel.text = differentArray[indexPath.row].restaurantPhoneNumber.toPhoneNumber()
            cell.categoryLabel.text = differentArray[indexPath.row].restaurantAlias
            cell.numberReviewsLabel.text = String(differentArray[indexPath.row].restaurantReview_count)
            cell.setImageView(theImageURL: differentArray[indexPath.row].restaurantImage_url)

            switch differentArray[indexPath.row].restaurantRating {
            case 0.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
            case 1.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_1")
            case 1.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_1_half")
            case 2.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_2")
            case 2.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_2_half")
            case 3.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_3")
            case 3.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_3_half")
            case 4.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_4")
            case 4.5:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_4_half")
            case 5.0:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_5")
            default:
                cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
            }
                
            return cell
        }
        
        return cell
    }

    //title section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0){
            return "Recommendations"
        }
        else {
            return "Other"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RestaurantDetailViewController
        destinationVC.chosenRestaurant = chosenRestaurant
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (indexPath.section == 0){
            chosenRestaurant = similarArray[indexPath.row]
        }
        else {
            chosenRestaurant = differentArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "recToDetail", sender: self)
        
    }
    

    
    
    func checkSimilar(restaurantID:String)
    {
        if search.favoriteRestaurants.count > 0
        {
                if currentUser.userReturned.favoriteRestaurants.contains(search.favoriteRestaurants[0].restaurantID)
                {
                    similarArray.append(search.favoriteRestaurants[0])
                }
                else
                {
                    differentArray.append(search.favoriteRestaurants[0])
                }
                search.favoriteRestaurants.removeAll()
                
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            if (globalIndex != globalCounter){
                search.getSingleRestaurant(restaurantID:friend.userReturned.favoriteRestaurants[globalIndex])
            }
            
            
            
        }
    }

}

extension RecommendationTableViewController: userProtocol
{
    func gotFriends() {}
    
    func gotRestaurants() {
                
        if currentUser.userReturned.favoriteRestaurants.isEmpty == false && friend.userReturned.favoriteRestaurants.isEmpty == false
        {
            globalCounter = friend.userReturned.favoriteRestaurants.count
            
            search.getSingleRestaurant(restaurantID: friend.userReturned.favoriteRestaurants[globalIndex])
            
        }
    }

    func gotError(error: Error) {
        print("Error")
    }
    
    func gotUserProfileImage() {
    }
}

extension RecommendationTableViewController : searchProtocol
{
    func UpdatUI(_ searchBrain: Search) {
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
    func singleSearchDone() {
        globalIndex += 1
        checkSimilar(restaurantID: search.favoriteRestaurants[0].restaurantID)
    }
}
