//
//  SignupViewController.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import UIKit

class SignupViewController: UIViewController {
      var errorMsgSignUp = ""
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var re_enterPassword: UITextField!
    
    
    @IBOutlet weak var userMobile: UITextField!
    
    @IBOutlet weak var labelErrormsg: UILabel!
    
    @IBAction func getOTP(_ sender: Any) {
        if inputValidation(name: userName.text!, email: userEmail.text!, password1: userPassword.text!, password2: re_enterPassword.text!, mobileNo: userMobile.text!){
            if regexValidation(name: userName.text!, email: userEmail.text!, password: userPassword.text!){
               if credentialValidation(email: userEmail.text!){
                   //getOTP(<#T##sender: Any##Any#>)
                   print("validated")
                   hideLabelErrormsg()
               }
                else {
                    labelErrormsg.text = errorMsgSignUp
                    labelErrormsg.textColor = UIColor.red
                }
            }
            else {
                labelErrormsg.text = errorMsgSignUp
                labelErrormsg.textColor = UIColor.red
            }
        
        }
        else {
            
            labelErrormsg.text = errorMsgSignUp
            labelErrormsg.textColor = UIColor.red
        }
        }

   // @IBAction func signIn(_ sender: Any) {
        //signup validation
      
   // }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabelErrormsg()
        // Do any additional setup after loading the view.
    }

    func hideLabelErrormsg(){
        labelErrormsg.text = ""
        labelErrormsg.textColor = view.backgroundColor
    }
    
}
