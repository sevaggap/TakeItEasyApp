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
    
    
    /// array to store quiz master data retrieved from DB
    var quizMasterData = [Quiz_MasterData]()
    
    /// array to store quiz transaction data retrieved from DB
    var quizTransData = [Quiz_TransactionData]()
    
    
    /// string used to temporarily stored SQL statements. Value would update before sqlite3 execution functions are called.
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
            print("Error. Cannot prepare TransDataTable. SQLite3 Error Msg: \(error)")
        }
    }
    
    
    //Part 3 - CRUD operations for master data
    
    //get SQLite3 Error msg and print -> used for DB crud operations
    func printSQLite3ErrorMsg() {
        let errorSQLite = String(cString: sqlite3_errmsg(dbPointer)!)
        print("SQLite3 Error: \(errorSQLite)")
    }
    
    /// CRUD - Create Quiz Master Data
    /// - Parameters: fields values of the record to be inserted
    ///   - quizID: Quiz ID Number as an NSNumber
    ///   - quizDesc: Quiz Title/Description as an NSString
    ///   - questionID: Quiz Question ID Number as an NSNumber
    ///   - questionDesc: Quiz Question Description as an NSString
    ///   - answerID: Quiz Answer Number as an NSNumber
    ///   - answerDesc: Quiz Answer Description as an NSString
    ///   - answerIsCorrect: An NSNumber of 0/1 indicating if the answer is correct
    func createQuizMaster( //insert quiz information to master data table
        quizID : NSNumber,
        quizDesc : NSString,
        questionID : NSNumber,
        questionDesc : NSString,
        answerID : NSNumber,
        answerDesc : NSString,
        answerIsCorrect : NSNumber
    ) {
        var statement : OpaquePointer?
        quizSQL = "INSERT INTO QUIZ_MASTER (" +
            "QUIZ_ID, " +
            "QUIZ_DESC, " +
            "QUIZ_QUESTIONID, " +
            "QUIZ_QUESTIONDESC, " +
            "QUIZ_ANSWERID, " +
            "QUIZ_ANSWERDESC, " +
            "ANSWER_ISCORRECT) VALUES (?,?,?,?,?,?,?)"
        
        //prepare the SQLite query
        if sqlite3_prepare(dbPointer, quizSQL, -1, &statement, nil) != SQLITE_OK {
            printSQLite3ErrorMsg()
        } else {
            //insert the quiz record field by field
            if !insertRecords(intValue: quizID) {
                printSQLite3ErrorMsg()
            } else {
                if !insertRecords(strValue: quizDesc) {
                    printSQLite3ErrorMsg()
                } else {
                    if !insertRecords(intValue: questionID) {
                        printSQLite3ErrorMsg()
                    } else {
                        if !insertRecords(strValue: questionDesc) {
                            printSQLite3ErrorMsg()
                        } else {
                            if !insertRecords(intValue: answerID) {
                                printSQLite3ErrorMsg()
                            } else {
                                if !insertRecords(strValue: answerDesc) {
                                    printSQLite3ErrorMsg()
                                } else {
                                    if !insertRecords(intValue: answerIsCorrect) {
                                        printSQLite3ErrorMsg()
                                    } else {
                                        print("Quiz saved in master data table.")
                                        fieldIndex = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
    /// Field Index is used as a counter of fields to be inserted. Init value = 1. Will increment when insertRecords functions are called.
    var fieldIndex : Int32 = 1
    
    /// abstract function to insert strings data to SQLite3 DB
    /// - Parameter strValue: the data for NSString (String) fields to be inserted
    /// - Returns: a boolean value returned by SQLite indicating if the string data got inserted successfully
    func insertRecords(strValue : NSString) -> Bool {
        fieldIndex += 1
        return sqlite3_bind_text(dbPointer, fieldIndex, strValue.utf8String, -1, nil) == SQLITE_OK
    }
    
    /// abstract function to insert integer data to SQLite3 DB
    /// - Parameter intValue: the data for NSNumber (Integer) fields to be inserted
    /// - Returns: a boolean value returned by SQLite indicating if the integer data got inserted successfully
    func insertRecords(intValue : NSNumber) -> Bool {
        fieldIndex += 1
        return sqlite3_bind_int(dbPointer, fieldIndex, intValue.int32Value) == SQLITE_OK
    }
    
    // TODO: - RUD OPERATIONS FOR QUIZ MASTER DATA. PLEASE FINISH THE FUNCTIONS BEFORE REMOVING THIS LINE
    func retrieveQuizMasterIndi() {}
    func retrieveQuizMasterArr() {}
    func updateQuizMaster() {}
    func deleteQuizMaster() {}
    
    
    //Part 4 - CRUD operations for transaction data
    // TODO: - CRUD OPERATIONS FOR QUIZ TRANSACTION DATA. PLEASE FINISH THE FUNCTIONS BEFORE REMOVING THIS LINE
    func createQuizTrans() {}
    func retrieveQuizTransIndi() {}
    func retrieveQuizTransArr() {}
    func updateQuizTrans() {}
    func deleteQuizTrans() {}
}
