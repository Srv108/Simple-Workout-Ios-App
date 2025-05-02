//
//  RegisterViewController.swift
//  FitnessApp
//
//  Created by Saurabh Kumar on 29/04/25.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submit(_ sender: Any) {
        let enteredName = name.text ?? ""
        let enteredEmail = email.text ?? ""
        let enteredPassword = password.text ?? ""
        let enteredConfirmPassword = confirmPassword.text ?? ""
        
        if enteredPassword != enteredConfirmPassword {
            let alert = UIAlertController(title: "Error", message: "Password and Confirm Password do not match!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let message = """
        Name: \(enteredName)
        Email: \(enteredEmail)
        Password: \(enteredPassword)
        """
        
        let alert = UIAlertController(title: "Registration Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
