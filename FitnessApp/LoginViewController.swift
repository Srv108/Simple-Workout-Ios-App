//
//  LoginViewController.swift
//  FitnessApp
//
//  Created by Saurabh Kumar on 24/04/25.
//

import UIKit

class LoginViewController: UIViewController {

        // MARK: - Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
        private let defaultEmail = "Saurav"
        private let defaultPassword = "1234"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTextFields()
        }
        
        private func setupTextFields() {
            txtEmail.placeholder = "Enter your email"
            txtEmail.keyboardType = .emailAddress
            txtEmail.autocapitalizationType = .none
            
            txtPass.placeholder = "Enter your password"
            txtPass.isSecureTextEntry = true
            
        }
        
        // MARK: - Login Action
    
    @IBAction func btnLoginClicked(_ sender: Any) {
    
            view.endEditing(true)
                
                guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty else {
                    showAlert(title: "Email Required", message: "Please enter your email address")
                    return
                }

                guard let password = txtPass.text, !password.isEmpty else {
                    showAlert(title: "Password Required", message: "Please enter your password")
                    return
                }

                if email != defaultEmail && password != defaultPassword {
                    showAlert(title: "Login Failed", message: "Invalid email or password")
                }
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

}
