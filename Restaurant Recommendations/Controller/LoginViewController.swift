//
//  ViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //log user in once entered email, password and click login button
    @IBAction func onLogin(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        FirebaseHelper().signInUser(userEmail: email, userPassword: password)
    }
    
    
}

