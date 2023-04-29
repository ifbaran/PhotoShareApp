//
//  Helper.swift
//  PhotoShareApp
//
//  Created by Baran on 27.04.2023.
//

import Foundation
import UIKit


class Helper: UIViewController, IHelper {
    
    func errorMessage(messageTitle: String, messageBody: String){
        let alert = UIAlertController(title: messageTitle, message: messageBody, preferredStyle: .alert);
        let okButton = UIAlertAction(title: "OK", style: .default);
        alert.addAction(okButton);
        self.present(alert, animated: true);
    }
}

protocol IHelper {
    func errorMessage(messageTitle: String, messageBody: String);
}
