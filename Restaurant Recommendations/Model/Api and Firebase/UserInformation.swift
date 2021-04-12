//
//  UserBrain.swift
//  Restaurant Recommendation
//
//  Created by Richard Basdeo on 4/4/21.
//

import Foundation
protocol userProtocol {
    mutating func gotFriends()
    mutating func gotRestaurants()
    mutating func gotError(error: Error)
    mutating func gotUserProfileImage()
}

class UserInformation: FirebaseHelper {
    
    var userReturned = User(email: "", friends: [], favoriteRestaurants: [], profilePicture: "")
    
    var userDelegate: userProtocol?
    
    
    
    
    //MARK:: Functions You Call
    func getTotalUserInfo(email: String){
        userReturned.email = email
        getUserRestaurants(email: email)
        getUserFriends(email: email)
        getUserProfilePicture(email: email)
    }
    
    
    
    
    func getUserRestaurants (email: String){
        
        let doesDocumentExists = self.database.collection(email).document("favoriteRestaurants")
        
        doesDocumentExists.getDocument { (document, error) in
            if let e = error {
                self.delegate?.error(error: e)
            }
            else {
                if let userData = document {
                    
                    self.userReturned.favoriteRestaurants = userData["myRestaurants"] as? [String] ?? []
                    self.userDelegate?.gotRestaurants()
                }
            }
        }
        
    }
    
    
    //get users friends, and favorited restaurants
    func getUserFriends (email: String){
        
        
        let doesDocumentExists = self.database.collection(email).document("friends")
        
        doesDocumentExists.getDocument { (document, error) in
            if let e = error {
                self.userDelegate?.gotError(error: e)
            }
            else {
                if let userData = document {
                    
                    self.userReturned.friends = userData["myFriends"] as? [String] ?? []
                    self.userDelegate?.gotFriends()
                }
            }
        }
    }
    
    func getUserProfilePicture(email: String){
        
        
        let doesDocumentExists = self.database.collection(email).document("profilePicture")
        
        doesDocumentExists.getDocument { (document, error) in
            if let e = error {
                self.userDelegate?.gotError(error: e)
            }
            else {
                if let userData = document {
                    
                    self.userReturned.profilePicture = userData["userProfilePicture"] as? String ?? ""
                    self.userDelegate?.gotUserProfileImage()
                }
            }
        }
    }
    
}
