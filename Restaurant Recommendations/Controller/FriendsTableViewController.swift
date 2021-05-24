//
//  FriendsTableViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit
import Firebase

class FriendsTableViewController: UITableViewController {

    let currentUser = UserInformation()
    var friendUser = UserInformation()
    var friendChose = ""
    var tempURL = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.userDelegate = self
        friendUser.userDelegate = self
    }
    
    //Get the current user's friends
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userEmail = Auth.auth().currentUser?.email {
            currentUser.getUserFriends(email: userEmail)
        }
    }
    
    
    //Once got current user's friends
    //Get friend's profile images
    func getImages() {
        
        for friend in currentUser.userReturned.friends {
            friendUser.getUserProfilePicture(email: friend)
        }
    }
    
    //Let Recommendation know which friend was chosen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RecommendationTableViewController
        destinationVC.friendChosen = friendChose
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentUser.userReturned.friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendTableViewCell
        cell.setEmail(userEmail: currentUser.userReturned.friends[indexPath.row])
        
        //Check to see if friend has a profile image
        for url in tempURL {
            
            if(url.contains(currentUser.userReturned.friends[indexPath.row])){
                cell.setImage(picURL: url)
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendChose = currentUser.userReturned.friends[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! FriendTableViewCell
        
        UIView.animate(withDuration: 1) {
            
            
            cell.friendEmail.isHidden = true
            
            
        } completion: { _ in
            
            UIView.animate(withDuration: 1) {
                cell.friendImage.transform = cell.friendImage.transform.rotated(by: .pi)
                cell.friendImage.transform = cell.friendImage.transform.rotated(by: .pi)
                
            } completion: { _ in
                
                cell.friendEmail.isHidden = false
                self.performSegue(withIdentifier: "friendsToRec", sender: self)
                
            }
        }

    }
}

extension FriendsTableViewController: userProtocol {
    
    //Once gor friends print their names
    func gotFriends() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        //Then get their profile images
        getImages()
        
    }
    
    func gotRestaurants() {
        
    }
    
    func gotError(error: Error) {
        
    }
    
    //add the image url to array that holds all profile images urls
    func gotUserProfileImage() {
        
        tempURL.append(friendUser.userReturned.profilePicture)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
