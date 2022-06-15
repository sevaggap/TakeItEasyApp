//
//  LoginViewController.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import UIKit

class LoginViewController: UIViewController {
    let userDefaults = UserDefaults.standard
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
                if switchState.isOn {
                    buttonSignInDidTouchUpInside_RememberMe(username: loginId.text!)
                                   } else {
                                    
                                       print("switch remember me is off")
                                   }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
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
//    func switchStatus(){
//            let switchStatus = userDefaults.bool(forKey: "switch")
//            let keyUsername = userDefaults.value(forKey: "username") as? String
//            if(switchStatus){
//                switchState.setOn(true, animated: false)
//                loginId.text = keyUsername
//                viewKey()
//            } else {
//                switchState.setOn(false, animated: false)
//            }
//        }
    
    func buttonSignInDidTouchUpInside_RememberMe(username : String) {
            //update keychain credential
            let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : loginId.text]

            let attributeUsername : [String : Any] = [kSecAttrAccount as String : username]
            let attributePassword : [String : Any] = [kSecValueData as String : loginPassword.text!.data(using: .utf8)]

            if SecItemUpdate(request as CFDictionary, attributePassword as CFDictionary) == noErr && SecItemUpdate(request as CFDictionary, attributeUsername as CFDictionary) == noErr {
                print("Credential updated in keychain.")
            } else {
                print("Error.")
            }
           
        }
    
}
