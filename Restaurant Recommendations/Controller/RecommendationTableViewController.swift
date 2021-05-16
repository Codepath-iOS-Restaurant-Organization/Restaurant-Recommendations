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
    var currentUser: UserInformation?
    var friend: UserInformation?
    var search = Search()
    
    //similar/different array
    var similarArray = [Restaurant]()
    var differentArray = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser?.userDelegate = self
        friend?.userDelegate = self
        search.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(friendChosen)
                
        if let current = Auth.auth().currentUser?.email
        {
            currentUser?.getUserRestaurants(email: current)
            friend?.getUserRestaurants(email: friendChosen)
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
        
        _ = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let dummyCell = UITableViewCell()

        if (indexPath.section == 0)
        {
            dummyCell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        else if (indexPath.section == 1)
        {
            return dummyCell
        }
        return dummyCell
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
    
    func checkSimilar(restaurantID:String)
    {
        if search.favoriteRestaurants.count > 0
        {
            if let user = currentUser
            {
                if user.userReturned.favoriteRestaurants.contains(search.favoriteRestaurants[0].restaurantID)
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
            }
        }
    }

}

extension RecommendationTableViewController: userProtocol
{
    func gotFriends() {
        if currentUser?.userReturned.favoriteRestaurants.isEmpty == false && friend?.userReturned.favoriteRestaurants.isEmpty == false
        {
            if let friend = friend
            {
                for id in friend.userReturned.favoriteRestaurants
                {
                    search.getSingleRestaurant(restaurantID: id)
                }
            }
        }
        
    }
    
    func gotRestaurants() {
        
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
        checkSimilar(restaurantID: search.favoriteRestaurants[0].restaurantID)
    }
}
