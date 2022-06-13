//
//  LoginValidation.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/8/22.
//


import Foundation
import CoreData




//Global function used to check if inputs are empty/nil
func inputNotNil (input : String?) -> Bool {
    if input != nil && input != "" && !input!.isEmpty {
        return true
    } else {
        return false
    }
}

//add user validation functionality for login view controller
extension LoginViewController {

    
    //validate if inputs of username and password are valid and update error message accordingly
    func inputValidation(username : String?, password : String?) -> Bool {
        
        var inputIsValid = false
        
        if !inputNotNil(input: username) {
            if inputNotNil(input: password) {
                errorMsgSignIn = "Please enter your username."
            } else {
                errorMsgSignIn = "Please enter your username and password."
            }
        }
        
        if inputNotNil(input: username) {
            if inputNotNil(input: password) {
                inputIsValid = true
            } else {
                errorMsgSignIn = "Please enter your password."
            }
        }
        
        return inputIsValid
    }
    
    //validate if password entered is correct and update error message accordingly
    func credentialValidation(email : String, password : String) -> Bool {

        var credentialIsValid = false
        //call readData function in DBHelper
        let emailIsRegistered : Bool = DBHelperUser.dbHelperUser.readUser(email: email)
        if !emailIsRegistered {
            errorMsgSignIn = "Username not found. Please sign up first."
        } else {
            let correctPassword = DBHelperUser.dbHelperUser.readUser(email: email).password
            if password == correctPassword {
                credentialIsValid = true
            } else {
                errorMsgSignIn = "Password incorrect. Please try again."
            }
        }
        return credentialIsValid
    }

}

//add functionalities to DBHelperUser to retrieve user information
extension DBHelperUser {
    
    //retrieve user as an instance of "User" entity to obtain correct passwords
    func readUser (email : String) -> User {
        var user = User()
        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetechRequest.predicate = NSPredicate(format: "email == %@", email)
        fetechRequest.fetchLimit = 1
        do {
            let result = try context?.fetch(fetechRequest) as! [User]
            if result.count != 0 {
                user = result.first as! User
                print("Email is registered.")
            } else {
                print("Email is NOT registered.")
            }
        } catch {
            print("Error. Cannot retrieve user information.")
        }
        return user
    }
    
    //retrieve user information to check if email is registered already
    func readUser (email : String) -> Bool {
        var emailIsRegistered = false

        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetechRequest.predicate = NSPredicate(format: "email == %@", email)
        fetechRequest.fetchLimit = 1
        do {
            let result = try context?.fetch(fetechRequest) as! [User]
            if result.count != 0 {
                emailIsRegistered = true
                print("Email is registered.")
            } else {
                emailIsRegistered = false
                print("Email is NOT registered.")
            }
        } catch {
            print("Error. Cannot retrieve user information.")
        }
        return emailIsRegistered
    }
}
