//
//  HomeViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit

class HomeViewController: UIViewController {
    let firebase = FirebaseHelper()
    
    @IBAction func onAddFriend(_ sender: Any) {
        addFriendAlert()
    }
    
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
    @IBAction func onLogout(_ sender: Any) {
        logoutAlert()
    }
    
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
