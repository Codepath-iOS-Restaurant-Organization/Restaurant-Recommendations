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
    
//    let similarArray = []
//    let differentArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(friendChosen)
                
        if let current = Auth.auth().currentUser?.email
        {
            currentUser?.getUserFriends(email: current)
            friend?.getUserFriends(email: friendChosen)
            
            friend?.userReturned.favoriteRestaurants
            currentUser?.userReturned.favoriteRestaurants
        }
    }

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        if section == 0
//        {
//            return similarArray.count
//        }
//        if section == 1
//        {
//            return differentArray.count
//        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
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
    

}
