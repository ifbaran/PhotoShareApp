//
//  SettingsViewController.swift
//  PhotoShareApp
//
//  Created by Baran on 27.04.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut();
            performSegue(withIdentifier: "toMainVC", sender: nil);
        }
        catch {
            print("Çıkış yapılamadı!");
        }
        
    }
    
}
