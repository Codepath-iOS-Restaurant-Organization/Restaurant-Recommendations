//
//  ViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let firebase = FirebaseHelper();
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firebase.delegate = self
    }

    
    @IBAction func onSignUp(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        firebase.signUpUser(userEmail: email, userPassword: password)
        
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        firebase.signInUser(userEmail: email, userPassword: password)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension LoginViewController: firebaseProtocols {
    func signUpSuccessful() {
        //take user to the home screen
        //set user default to true
    }

    func signInSuccessful() {
        
    }

    func signedOutSuccessful() {
        
    }

    func error(error: Error) {
        print("Error Signing Up: \(error.localizedDescription)")
    }

    func friendAdded() {}

    func restaurantAdded() {}

    func profilePictureUploaded() {}
}


