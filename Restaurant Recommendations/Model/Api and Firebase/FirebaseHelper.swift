//
//  FirebaseHelper.swift
//  Restaurant Recommendation
//
//  Created by Richard Basdeo on 4/3/21.
//

import Foundation
import Firebase

protocol firebaseProtocols {
    func signUpSuccessful()
    func signInSuccessful()
    func signedOutSuccessful()
    func error(error: Error)
    func friendAdded()
    func restaurantAdded()
    func profilePictureUploaded()
}
class FirebaseHelper {
    
    var delegate: firebaseProtocols?
    
    let database = Firestore.firestore()
    
    let storage = Storage.storage()
    
    
    //MARK:: Functions You Call
    func signUpUser(userEmail: String, userPassword: String){
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (results, error) in
            
            if let e = error {
                self.delegate?.error(error: e)
            }
            else {
                self.delegate?.signUpSuccessful()
            }
        }
    }
    
    
    func signInUser(userEmail: String, userPassword: String) {
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            
            if let e = error {
                self.delegate?.error(error: e)
            }
            
            else {
                self.delegate?.signInSuccessful()
            }
            
        }
    }
    
    
    func signOutUser () {
        
        do {
            try Auth.auth().signOut()
            delegate?.signedOutSuccessful()
        }
        catch{
            delegate?.error(error: error)
        }
    }
    
    
    func addFriend(friendName: String){
        
        checkToSeeIfCollectionExists(theFriend: friendName,
                                     documentName: "friends",
                                     restaurantID: "",
                                     profileURL: URL(string:""))
    }
    
    func addFavoriteRestaurant(theID: String) {
        
        checkToSeeIfCollectionExists(theFriend: "",
                                     documentName: "favoriteRestaurants",
                                     restaurantID: theID,
                                     profileURL: URL(string:""))
        
    }
    
    func uploadProfilePicture(email: String, image: UIImage){
        
        let storageReference = storage.reference()
        
        let imagesRef = storageReference.child("profilePictures")
        
        let fileName = "\(email).jpg"
        
        let spaceRef = imagesRef.child(fileName)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        if let imageData = image.pngData(){
            
            
            let uploadTask = spaceRef.putData(imageData, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                print ("Error uploading file")
                return
              }
              
                
              spaceRef.downloadURL { (url, error) in
                guard let downloadURL = url else {return}
                
                self.checkToSeeIfCollectionExists(theFriend: "",
                                             documentName: "profilePicture",
                                             restaurantID: "",
                                             profileURL: downloadURL)
                 
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: My helper functions
    func checkToSeeIfCollectionExists(theFriend: String,
                                      documentName: String,
                                      restaurantID: String,
                                      profileURL: URL?) {
        
        if let email = Auth.auth().currentUser?.email {
            
            let doesDocumentExists = self.database.collection(email).document(documentName)
            
            doesDocumentExists.getDocument { (returnDocument, error) in
                
                
                if let document = returnDocument {
                    
                    
                        if document.exists {
                            
                            if (documentName == "friends"){
                                self.updateFriends(friendName: theFriend, userEmail: email)
                                self.updateFriends(friendName: email, userEmail: theFriend)
                
                            }
                            else if (documentName == "favoriteRestaurants"){
                                
                                self.updateRestaurantList(newFavorite: restaurantID, userEmail: email)
                                
                            }
                            else if (documentName == "profilePicture"){
                                
                                if let profileURL = profileURL{
                                    
                                    self.updateProfilePicture(url: profileURL, userEmail: email)
                                    
                                }
                            }
                            
                            
                        }
                        else {
                            if (documentName == "friends"){
                                self.createFriends(friendName: theFriend, userEmail: email)
                                self.updateFriends(friendName: email, userEmail: theFriend)
                            }
                            else if (documentName == "favoriteRestaurants"){
                                
                                self.createRestaurantList(newFavorite: restaurantID, userEmail: email)
                                
                        }
                            else if (documentName == "profilePicture"){
                                
                                if let profileURL = profileURL{
                                    
                                    self.updateProfilePicture(url: profileURL, userEmail: email)
                                    
                                }
                                
                            }
                        
                    }
                }
            }
        }
        
    }
    
    
    
    
    func updateProfilePicture(url: URL, userEmail: String){
        
        database.collection(userEmail).document("profilePicture").setData(["userProfilePicture" : url.absoluteString]) { (error) in
            
            if let e = error {
                print(e.localizedDescription)
            }
            else {
                self.delegate?.profilePictureUploaded()
            }
            
        }
        
    }
    
    
    
    
    
    func updateRestaurantList (newFavorite: String, userEmail: String){
        
        var temp = [String]()
        database.collection(userEmail).document("favoriteRestaurants").getDocument { (document, error) in
            if let e = error {
                self.delegate?.error(error: e)
            }
            else {
                if let theData = document {
                    temp = theData["myRestaurants"] as! [String]
                    temp.append(newFavorite)
                    
                    
                    
                    self.database.collection(userEmail).document("favoriteRestaurants")
                        .setData(["myRestaurants" : temp]) { (error) in
                            if let e = error {
                                self.delegate?.error(error: e)
                            }
                            else {
                                self.delegate?.restaurantAdded()
                            }
                        }
                }
    
            }
        }
    }
    
    func createRestaurantList(newFavorite: String, userEmail: String){
         
        var temp = [String]()
        temp.append(newFavorite)
        self.database.collection(userEmail).document("favoriteRestaurants")
            .setData(["myRestaurants" : temp]) { (error) in
                if let e = error {
                    self.delegate?.error(error: e)
                }
                else {
                    self.delegate?.restaurantAdded()
                }
            }  
    }
    
    func updateFriends (friendName: String, userEmail: String){
        
        var temp = [String]()
        
        database.collection(userEmail).document("friends").getDocument { (document, error) in
            if let e = error {
                self.delegate?.error(error: e)
            }
            else {
                
                if let theData = document {
                    temp = theData["myFriends"] as? [String] ?? []
                    temp.append(friendName)
                    
                    
                    self.database.collection(userEmail).document("friends")
                        .setData(["myFriends" : temp]) { (error) in
                            if let e = error {
                                self.delegate?.error(error: e)
                            }
                            else {
                                self.delegate?.friendAdded()
                            }
                        }
                }
            }
        }
    }
    
    func createFriends(friendName: String, userEmail: String){
        
        let temp: [String] = [friendName]
        
        database.collection(userEmail).document("friends")
            .setData(["myFriends" : temp]) { (error) in
                if let e = error {
                    self.delegate?.error(error: e)
                }
                else {
                    self.delegate?.friendAdded()
                }
            }
        
    }
    
    func reverseAdd (userToEdit: String, currentUser: String) {
        
        
        let doesDocumentExists = self.database.collection(userToEdit).document("friends")
        
        doesDocumentExists.getDocument { (returnDocument, error) in
            
            
            if let document = returnDocument {
                
                if document.exists {
                    
                    self.updateFriends(friendName: userToEdit, userEmail: currentUser)
                }
                else {
                    
                    self.createFriends(friendName: currentUser, userEmail: userToEdit)
                    
                }
            }
        }
    }
}
