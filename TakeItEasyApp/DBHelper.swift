//
//  DBHelper.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//

import Foundation
import UIKit
import CoreData
class DBHelper{
    static var dbHelper = DBHelper()
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
  
    func doesNameExist(nameValue: String) -> Bool{
                var user = User()
                var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                fetchRequest.predicate = NSPredicate(format: "namevalue == %@", nameValue)
                do{
                    let login  =  try context?.fetch(fetchRequest)
                    if (login?.count != 0){
                            return true
                        }
                    }
                catch{
                    print("error in update")
                }
                return false
            }
    
    
    
    
    
}
