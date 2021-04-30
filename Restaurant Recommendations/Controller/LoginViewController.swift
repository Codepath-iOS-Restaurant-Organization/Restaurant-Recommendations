//
//  ViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    let firebase = FirebaseHelper()
    @IBAction func onLogin(_ sender: Any) {
        firebase.signInUser(userEmail: "colors@gmail.com", userPassword: "colors")
        self.performSegue(withIdentifier: "loginToHome", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        firebase.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension LoginViewController: firebaseProtocols{
    func signUpSuccessful() {
        print("Signed up")
    }
    
    func signInSuccessful() {
        print("signed in")
    }
    
    func signedOutSuccessful() {
        
    }
    
    func error(error: Error) {
        print("unsuccess \(error.localizedDescription)")
    }
    
    func friendAdded() {
        
    }
    
    func restaurantAdded() {
        
    }
    
    func profilePictureUploaded() {
        
    }
    
    
}
