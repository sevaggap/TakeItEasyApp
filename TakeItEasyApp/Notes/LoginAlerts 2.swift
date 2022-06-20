//
//  LoginAlerts.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-16.
//

import Foundation
import UIKit

extension LoginViewController {
        
    func alert(message : String) {
        
        print("in alert")

        let alert = UIAlertController(title: "Problem Logging In", message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
}

extension SignupViewController {
    
    func alert(message : String) {
        
        print("in alert")

        let alert = UIAlertController(title: "Problem Signing Up", message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
}
