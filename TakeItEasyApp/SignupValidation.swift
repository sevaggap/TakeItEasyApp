////
////  SignupValidation.swift
////  TakeItEasyApp
////
////  Created by Xavier on 6/8/22.
////
//
//import Foundation
//
////add user validation functionality for signup view controller
//extension SignupViewController {
//    
//    //validate if inputs in fields on signup screen are valid and update error message accordingly
//    func inputValidation(
//        name : String?,
//        email : String?,
//        password1 : String?,
//        password2 : String?,
//        mobileNo : String?) -> Bool {
//            var inputIsValid = false
//            if !inputNotNil(input: name) {
//                errorMsgSignUp = "Please enter your name."
//            } else {
//                if !inputNotNil(input: email) {
//                    errorMsgSignUp = "Please enter your email."
//                } else {
//                    if !inputNotNil(input: password1) || !inputNotNil(input: password2) {
//                        errorMsgSignUp = "Please enter your password."
//                    } else {
//                        if !inputNotNil(input: mobileNo) {
//                            errorMsgSignUp = "Please enter your mobile number."
//                        } else {
//                            if password1 != password2 {
//                                errorMsgSignUp = "Passwords don’t match."
//                            } else {
//                                inputIsValid = true
//                            }
//                        }
//                    }
//                }
//            }
//            return inputIsValid
//    }
//    
//    //validate inputs of fields on signup screen meet regex requirement and update error message accordingly
//    func regexValidation(name : String, email : String, password : String) -> Bool {
//        var regexValidationPassed = false
//        if !isValidEmail(email: email) {
//            errorMsgSignUp = "Please enter a valid email address."
//        } else {
//            if !isValidName(name: name) {
//                errorMsgSignUp = "Your name should be at least 3 characters."
//            } else {
//                if !isLongPassword(password: password) {
//                    errorMsgSignUp = "Please enter a longer password with at least 8 characters."
//                } else {
//                    if !isStrongPassword(password: password) {
//                        errorMsgSignUp = "Please enter a stronger password with at least one uppercase, one lowercase character, one number and one special character (!@#$&*)."
//                    } else {
//                        regexValidationPassed = true
//                    }
//                }
//            }
//        }
//        return regexValidationPassed
//    }
//    
//    func isValidEmail(email : String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        return regexValidation(value: email, regex: emailRegEx)
//    }
//    
//    func isValidName(name : String) -> Bool {
//        var nameIsValid = false
//        if name.count >= 3 {
//            nameIsValid = true
//        }
//        return nameIsValid
//    }
//    
//    func isLongPassword(password : String) -> Bool {
//        var passwordIsLong = false
//        if password.count >= 8 {
//            passwordIsLong = true
//        }
//        return passwordIsLong
//    }
//    
//    func isStrongPassword(password : String) -> Bool {
//        var passwordIsStrong = false
//        let passwordContainsDigit = regexValidation(value: password, regex: ".*[0-9]+.*")
//        let passwordContainsUpperChar = regexValidation(value: password, regex: ".*[A-Z]+.*")
//        let passwordContainsLowerChar = regexValidation(value: password, regex: ".*[a-z]+.*")
//        let passwordContainsSpecialChar = regexValidation(value: password, regex: ".*[!@#$&*]+.*")
//        if passwordContainsDigit && passwordContainsUpperChar && passwordContainsLowerChar && passwordContainsSpecialChar {
//            passwordIsStrong = true
//        } else {
//            errorMsgSignUp = "Your password should contain at least: 1 number, 1 uppercase letter, 1 lowercase letter and 1 special character."
//        }
//        return passwordIsStrong
//    }
//    
//    func regexValidation(value : String, regex : String) -> Bool {
//        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return validationPredicate.evaluate(with: value)
//    }
//    
//    //validate if email is already registered and update error message accordingly
//    func credentialValidation(email : String) -> Bool {
//        var emailIsRegistered : Bool = DBHelperUser.dbHelperUser.readUser(email: email)
//        
//        if emailIsRegistered {
//            errorMsgSignUp = "Username exists, Please go back to sign in."
//        } else {
//            OTPValidation()
//        }
//        
//        return !emailIsRegistered
//    }
//    
//    func OTPValidation(){}
//}
