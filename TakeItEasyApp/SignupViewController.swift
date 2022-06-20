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
    
    @IBOutlet weak var enteredOTP: UITextField!
    
    @IBOutlet weak var labelErrormsg: UILabel!
    
    var OTP : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabelErrormsg()
    }
    
    @IBAction func getOTP(_ sender: Any) {
        if inputValidation(name: userName.text!, email: userEmail.text!, password1: userPassword.text!, password2: re_enterPassword.text!, mobileNo: userMobile.text!){
            if regexValidation(name: userName.text!, email: userEmail.text!, password: userPassword.text!){
               if credentialValidation(email: userEmail.text!){
                   
                   OTP = Int.random(in: 100000...999999)
            
                   let OTPMessage = UIAlertController(title: "Alert", message: "Your OTP is \(OTP!)", preferredStyle: .alert)
                   
                   let alert = UIAlertController(title: "Your OTP is: \(OTP!)", message: "Please enter your OTP below", preferredStyle: .alert)
                   
                   let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                       guard let fields = alert.textFields, fields.count == 1 else {
                           return
                       }
                       let OTPField = fields[0]
                       guard let inputedOTP = OTPField.text, !inputedOTP.isEmpty else {
                           return
                       }
                       self.confirmOTP(userOTP: Int(inputedOTP)!)
                       
                   })

                   let cancel =  UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                   
                   alert.addTextField { field in
                       field.placeholder = "OTP"
                   }
                   alert.addAction(confirm)
                   alert.addAction(cancel)
                   
                   present(alert, animated: true)
                   
                   //call saveLastUser function
                   print("validated")
                   print("hello")
                   hideLabelErrormsg()
               }
                else {
                  alert(message: errorMsgSignUp)
                }
            }
            else {
                alert(message: errorMsgSignUp)
            }
        }
        else {
            alert(message: errorMsgSignUp)
        }
    }
    
    func confirmOTP(userOTP : Int) {
                
        if( userOTP == OTP!){
            DBHelper.dbHelper.addData(nameValue: userName.text!, passValue: userPassword.text!, emailValue: userEmail.text!)
            let userCreatedAlert = UIAlertController(title: "User Successfully Created!", message: "Please login!", preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                
                let storyboard = UIStoryboard(name: "Bristy", bundle: nil)
                let loginScreen = storyboard.instantiateViewController(withIdentifier: "loginVC")
                loginScreen.modalPresentationStyle = .fullScreen
                self.present(loginScreen, animated: true, completion: nil)
                
            })
            
            userCreatedAlert.addAction(confirm)
            present(userCreatedAlert, animated: true)
            
        } else {
            let wrongOTPAlert = UIAlertController(title: "Incorrect OTP", message: "The OTP you entered was inccorect! Please try again.", preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            
            wrongOTPAlert.addAction(confirm)
            
            present(wrongOTPAlert, animated: true)

        }
      
    }

    func hideLabelErrormsg(){
        labelErrormsg.text = ""
        labelErrormsg.textColor = view.backgroundColor
    }
    func saveLastUser(){
        let userDefault = UserDefaults.standard
        userDefault.set(userName, forKey: "lastUser")
    }
}
