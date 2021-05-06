//
//  HomeViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let firebase = FirebaseHelper()
    
    @IBAction func onAddFriend(_ sender: Any) {
        addFriendAlert()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        logoutAlert()
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBAction func onProfileImage(_ sender: Any) {
        print("tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    //Code for addFriend button:
    func addFriendAlert(){
        let alert = UIAlertController(title: "Add Friend", message: "Please enter user's email", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {action in
            let email: String = alert.textFields![0].text!
            self.firebase.addFriend(friendName: email)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in print("canceled")}))
        present(alert, animated: true)

    }
    
    //Code for logout button:
    func logoutAndLeave(){
        firebase.signOutUser()
        UserDefaults.standard.set(false, forKey: "loginSuccess")
        self.dismiss(animated: true, completion: nil)
    }
    
    func logoutAlert(){
        let alert = UIAlertController(title: "Log Out?", message: "You can always access your content by logging back in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in print("canceled")}))
        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { [self]action in logoutAndLeave()}))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebase.delegate = self
        profileImageView.layer.masksToBounds = true
           profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension HomeViewController: firebaseProtocols{
    func signUpSuccessful() {
        print("signed up")
    }
    
    func signInSuccessful() {
        print("signed in")
    }
    
    func signedOutSuccessful() {
        print("signed out")
    }
    
    func error(error: Error) {
        print("unsuccess \(error.localizedDescription)")
        
    }
    
    func friendAdded() {
        print("added successfully")
    }
    
    func restaurantAdded() {

    }
    
    func profilePictureUploaded() {

    }
}
