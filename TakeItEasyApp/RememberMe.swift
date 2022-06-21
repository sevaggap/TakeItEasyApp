//
//  RememberMe.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/20/22.
//

import Foundation

extension LoginViewController {
    
    func readKeyChainRecord(username : String) -> Bool {
        var isPasswordInKeyChain = false
        
        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        var response : CFTypeRef?
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            isPasswordInKeyChain = true
        } else {
            print("Error or password not found in keychain.")
        }
        
        return isPasswordInKeyChain
    }
    func readKeyChainRecord(username : String) -> String {
        var passwordUnencrypted = ""
        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        var response : CFTypeRef?
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            let data = response as? [String : Any]
            let username = data![ kSecAttrAccount as String] as? String
            let passwordEncrypted = (data![ kSecValueData as String] as? Data)!
            passwordUnencrypted = String(data: passwordEncrypted, encoding: .utf8)!
            print(username!,passwordUnencrypted)
        } else {
            print("Error.")
        }
        return passwordUnencrypted
    }
    func createKeyChainRecord() {
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : loginId.text, kSecValueData as String : loginPassword.text!.data(using: .utf8)]
        
        if SecItemAdd(attribute as CFDictionary, nil) == noErr {
            print("Password saved in keychain.")
        } else {
            print("Error or password not saved in keychain.")
        }
    }
}
