//
//  SignUpViewController.swift
//  Restaurant Recommendations
//
//  Created by Shi Tao Luo on 4/22/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailSignUpTextField: UITextField!
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //calls backend and sign up user
    @IBAction func onSignUp(_ sender: Any) {
        let email = emailSignUpTextField.text!
        let password = passwordSignUpTextField.text!
        
        FirebaseHelper().signUpUser(userEmail: email, userPassword: password)
    }
}
