//
//  ViewController.swift
//  PhotoShareApp
//
//  Created by Baran on 27.04.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // hilalim@gmail.com - 123456
    @IBAction func loginButtonClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                if error != nil {
                    self.errorMessage(messageTitle: "Hata!", messageBody: error?.localizedDescription ?? "Hata alındı tekrar deneyiniz!");
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            };
        }
        else {
            errorMessage(messageTitle: "Hata!", messageBody: "E-Mail ve şifre giriniz!");
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                if error != nil {
                    self.errorMessage(messageTitle: "Hata!", messageBody: error?.localizedDescription ?? "Hata alındı tekrar deneyiniz!");
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            };
        }
        else {
            errorMessage(messageTitle: "Hata!", messageBody: "E-Mail ve şifre giriniz!");
        }
        
    }
    
    
    func errorMessage(messageTitle: String, messageBody: String){
        let alert = UIAlertController(title: messageTitle, message: messageBody, preferredStyle: .alert);
        let okButton = UIAlertAction(title: "OK", style: .default);
        alert.addAction(okButton);
        self.present(alert, animated: true);
    }
}

