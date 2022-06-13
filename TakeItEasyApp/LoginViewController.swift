//
//  LoginViewController.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import UIKit

class LoginViewController: UIViewController {

    var errorMsgSignIn = ""
    
    @IBOutlet weak var errormsgLabel: UILabel!
    
    @IBOutlet weak var loginId: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var switchState: UISwitch!
    
   
    @IBAction func signIn(_ sender: Any) {
        //login validation
        if inputValidation(username: loginId.text, password: loginPassword.text){
            if credentialValidation(email: loginId.text!, password: loginPassword.text!){
             hideLabelErrormsg()
            let storyboard = UIStoryboard(name: "Bristy", bundle: nil)
                let tabBar = storyboard.instantiateViewController(withIdentifier: "tabBar")
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true, completion: nil)
                
            }
            else {
                errormsgLabel.text = errorMsgSignIn
                errormsgLabel.textColor = .red
            }
        }
        else {
            errormsgLabel.text = errorMsgSignIn
            errormsgLabel.textColor = .red
        }
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
         hideLabelErrormsg()
        // Do any additional setup after loading the view.
    }
    
    func hideLabelErrormsg(){
        errormsgLabel.text = ""
        errormsgLabel.textColor = view.backgroundColor
    }

}
