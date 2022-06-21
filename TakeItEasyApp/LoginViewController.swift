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
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         hideLabelErrormsg()
        viewDidLoad_PopulateCredentialInKeyChain()
        
//        fetchBooks.getGeneral(completion: {
//            result in
//            switch result{
//            case .failure(let error):
//                print("Error Message",error)
//            case .success(let res):
//                print("genBooks loaded")
//                }
//          }
//      )
//        
//        fetchBooks.getTechnical(completion: {
//            result in
//            switch result{
//            case .failure(let error):
//                print("Error Message",error)
//            case .success(let res):
//                print("techBooks loaded")
//
//                }
//          }
//      )
//        
//        fetchBooks.getRecipes(completion: {
//            result in
//            switch result{
//            case .failure(let error):
//                print("Error Message",error)
//            case .success(let res):
//                print("recBooks loaded")
//
//                }
//          }
//      )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if traitCollection.userInterfaceStyle == .dark
                {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground-Dark")
        } else {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark
                {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground-Dark")
        } else {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground")
        }
    }
   
    @IBAction func signIn(_ sender: Any) {
        
        //login validation
        if inputValidation(username: loginId.text, password: loginPassword.text){
            if credentialValidation(email: loginId.text!, password: loginPassword.text!){
             hideLabelErrormsg()
                if switchState.isOn {
                    buttonSignInDidTouchUpInside_RememberMe(username: loginId.text!)
                                   } else {
                                       let userDefault = UserDefaults.standard
                                       userDefault.set(loginId.text, forKey: "lastUser")
                                       userDefault.set(false, forKey: "lastUserSwitchedOnRememberMe")
                                       print("switch remember me is off")
                                   }
                
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBar = storyboard.instantiateViewController(withIdentifier: "navBarLoggedIn")
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true, completion: nil)
                
            }
            else {
//                errormsgLabel.text = errorMsgSignIn
//                errormsgLabel.textColor = .red
                alert(message: errorMsgSignIn)
            }
        }
        else {
            alert(message: errorMsgSignIn)
        }
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    func hideLabelErrormsg(){
        errormsgLabel.text = ""
        errormsgLabel.textColor = view.backgroundColor
    }
    
    
    func buttonSignInDidTouchUpInside_RememberMe(username : String) {
        if !readKeyChainRecord(username: username) {
            createKeyChainRecord()
        }
        
        //update keychain username to this time in UD
        let userDefault = UserDefaults.standard
        userDefault.set(username, forKey: "lastUser")
        userDefault.set(true, forKey: "lastUserSwitchedOnRememberMe")
    }
    
    func viewDidLoad_PopulateCredentialInKeyChain() {
        let userDefault = UserDefaults.standard
        let username = userDefault.string(forKey: "lastUser")
        let lastRememberSwitchIsOn = userDefault.bool(forKey: "lastUserSwitchedOnRememberMe")
        if lastRememberSwitchIsOn {
            print("Last User: \(username)")
            loginId.text = username
            loginPassword.text = readKeyChainRecord(username: username!)
        } else {
            self.loginId.text = ""
            self.loginPassword.text = ""
        }
    }
}
