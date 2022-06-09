//
//  LoginViewController.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import UIKit

class LoginViewController: UIViewController {

    var errorMsgSignIn = ""
    
    
    @IBOutlet weak var loginId: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var switchState: UISwitch!
    
   
    @IBAction func signIn(_ sender: Any) {
        //login validation
        
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
