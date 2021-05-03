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
        firebase.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "loginSuccess")
        {
            performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
}

extension LoginViewController: firebaseProtocols {
    func signUpSuccessful() {
        //take user to the home screen
        //set user default to true
        UserDefaults.standard.set(true, forKey: "loginSuccess")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }

    func signInSuccessful() {
        UserDefaults.standard.set(true, forKey: "loginSuccess")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
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


