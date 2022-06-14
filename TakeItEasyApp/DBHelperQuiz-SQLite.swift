//
//  DBHelperQuiz-SQLite.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/14/22.
//
import Foundation
import SQLite3


//SQLite3 DBHelper for quiz master & transaction data


class DBHelperQuiz {
    
    
    //Part 1 - Declare cross class vars
    static var dbHelper = DBHelperQuiz() //static instance for DBHelperQuiz
    var dbPointer : OpaquePointer? //declare an opaque pointer (A wrapper around an opaque C pointer.)
    
    //arrays to store quiz info & users' answer
    var quizMasterData = [Quiz_MasterData]()
    var quizTransData = [Quiz_TransactionData]()
    
    //string for SQL statements
    var quizSQL = ""
    
    //Part 2 - Initialize Database & Tables
    func prepareDataBase() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("QuizDetailDB.sqlite")
        if sqlite3_open(filePath.path, &dbPointer) != SQLITE_OK {
            print("Error: Cannot create/open database 'QuizDetailDB.sqlite'.")
        }
    }
    
    func prepareMasterDataTable(){
        quizSQL =
            "CREATE TABLE IF NOT EXISTS QUIZ_MASTER (" +
            "ROW_ID INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "QUIZ_ID INTEGER, " +
            "QUIZ_DESC TEXT, " +
            "QUIZ_QUESTIONID INTEGER, " +
            "QUIZ_QUESTIONDESC TEXT, " +
            "QUIZ_ANSWERID INTEGER, " +
            "QUIZ_ANSWERDESC TEXT, " +
            "ANSWER_ISCORRECT INTEGER)"
        if sqlite3_exec(dbPointer, quizSQL, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(dbPointer)!)
            print("Error. Cannot prepare MasterDataTable. SQLite3: \(error)")
        }
    }
    
    func prepareTransDataTable(){
        quizSQL =
            "CREATE TABLE IF NOT EXISTS QUIZ_TRANS (" +
            "ROW_ID INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "QUIZ_ID INTEGER, " +
            "USER_ID TEXT, " +
            "IS_COMPLETED INTEGER, " +
            "COMPLETED_AT TEXT, " +
            "USER_RESPID INTEGER)"
        if sqlite3_exec(dbPointer, quizSQL, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(dbPointer)!)
            print("Error. Cannot prepare TransDataTable. SQLite3: \(error)")
        }
    }
    
    
    //Part 3 - CRUD operations for master data
//    func insertData(name : NSString , course : NSString) {
//        var statement : OpaquePointer?
//        let query = "INSERT INTO QUIZ_MASTER (NAME, COURSE) VALUES (?,?)"
//        
//        if sqlite3_prepare(dbpointer, query, -1, &statement, nil) != SQLITE_OK {
//            let error = String(cString: sqlite3_errmsg(dbpointer)!)
//            print("Error. Cannot prepare SQL query. SQLite3: \(error)")
//        }
//        
//        if sqlite3_bind_text(statement, 1, name.utf8String, -1, nil) != SQLITE_OK {
//            let error = String(cString: sqlite3_errmsg(dbpointer)!)
//            print("Error. Cannot save name. SQLite3: \(error)")
//        }
//        
//        if sqlite3_bind_text(statement, 2, course.utf8String, -1, nil) != SQLITE_OK {
//            let error = String(cString: sqlite3_errmsg(dbpointer)!)
//            print("Error. Cannot save course. SQLite3: \(error)")
//        }
//        
//        if sqlite3_step(statement) != SQLITE_DONE {
//            let error = String(cString: sqlite3_errmsg(dbpointer)!)
//            print("Error. Cannot create table. SQLite3: \(error)")
//        }
//        
//        print("Data saved.")
//    }
    
    
    //Part 4 - CRUD operations for transaction data
}
