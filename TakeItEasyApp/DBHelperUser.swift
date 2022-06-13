//
//  DBHelper.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import Foundation
import UIKit
import CoreData
class DBHelperUser{
    static var dbHelperUser = DBHelperUser()
    let context  = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func addData(nameValue : String , passValue : String, emailValue : String){
         let user  = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
         user.name = nameValue
         user.password = passValue
        user.email = emailValue
         
                 do {
                     try context?.save()
                     print("User data saved ")
                 }
                 catch{
                     print("got error")
                 }
         
     }
  
    
}
