//
//  SignupViewController.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import UIKit
import UserNotifications

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
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    @IBAction func getOTP(_ sender: Any) {
        if inputValidation(name: userName.text!, email: userEmail.text!, password1: userPassword.text!, password2: re_enterPassword.text!, mobileNo: userMobile.text!){
            if regexValidation(name: userName.text!, email: userEmail.text!, password: userPassword.text!){
               if credentialValidation(email: userEmail.text!){
                   
                   sendNotification()
                                                  
                   let alert = UIAlertController(title: "OTP Confirmation", message: "Please enter your OTP below", preferredStyle: .alert)
                   
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
                
        if(userOTP == OTP!){
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

extension SignupViewController : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
    
    func sendNotification(){
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {notify in
            switch notify.authorizationStatus{
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){ granted, err in
                    if let error = err {
                        print("error in permission")
                    }
                    self.generateNotification()
                }
            case .authorized:
                self.generateNotification()
            case.denied:
                print("permission not graned")
            default:
                print("")
            }
        })
        
    }
    
    func generateNotification(){
        OTP = Int.random(in: 100000...999999)
        let content = UNMutableNotificationContent()
        content.title = "OTP"
        content.subtitle = "From Take it Easy"
        content.body = "Your OTP is \(OTP!)"
        
        let timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "OTP", content: content, trigger: timeInterval)
        UNUserNotificationCenter.current().add(request)
        
    }
}
