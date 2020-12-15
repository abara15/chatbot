//
//  SignInVC.swift
//  chatBot
//
//  Created by Anthony Barakat on 6/27/18.
//  Copyright © 2018 Anthony Barakat. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    private let contactsSegue = "ContactsSegue";
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: contactsSegue, sender: nil);
        
        if emailTextfield.text != "" && passwordTextfield.text != "" { // When there is no value for email and password, we need to handle errors, which we did in AuthProvider.swift. ;oginHandler is error message.
            AuthProvider.Instance.login(withEmail: emailTextfield.text!, password: passwordTextfield.text!, loginHandler: { (message) in
                
                // We inform user what is going on.
                if message != nil {
                    self.alertTheUser(title: "Problem with authentication", message: message!);
                } else {
                    self.emailTextfield.text = "";
                    self.passwordTextfield.text = "";
                    self.performSegue(withIdentifier: self.contactsSegue, sender: nil);
                }
                
            });
        } else {
            alertTheUser(title: "Email and password are required.", message: "Please enter your email and password in the valid text fields.");
        }
        
    }
    @IBAction func signUp(_ sender: Any) {
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil); // Creates a button which we add to the alert.
        alert.addAction(ok);
        present(alert, animated: true, completion: nil); // We present this alert to the user.
    }

} // class
