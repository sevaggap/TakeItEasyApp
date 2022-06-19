//
//  QuizViewController.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/16/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var collectionViewQuiz: UICollectionView!
    @IBOutlet weak var pickerViewQuiz: UIPickerView!
    @IBOutlet weak var labelCurrentQuestionDesc: UILabel!
    
    @IBAction func buttonSubmitAnswersDidTouchUpInside(_ sender: Any) {
        if currentQuestionID + 1 == QuizArrFiltered[QuizIDFromCollView - 1].questions.count {
            //update numberOfCorrect
            if selectedAnswer.1 {
                numberOfCorrect += 1
                print("Correct")
            }
            
            //get current data in yyyyMMddHHmmss
            let dateformatter = DateFormatter()
            let currentTime = Date()
            dateformatter.timeZone = TimeZone(abbreviation: "EST")
            dateformatter.dateFormat = "yyyyMMddHHmmss"
            let completedAt = dateformatter.string(from: currentTime)
            
            //saved quiz result in DB
            DBHelperQuiz.dbHelperQuiz.createQuizResult(quizID: QuizIDFromCollView as! NSNumber, isCompleted: 1 as! NSNumber, numberOfCorrect: numberOfCorrect as! NSNumber, userEmail: currentUserEmail() as! NSString, completedAt: completedAt as! NSString)
            
            print("Result Saved in DB.")
            //clear numberofCorrect
            numberOfCorrect = 0
            
            //hide label & pickerview
            labelCurrentQuestionDesc.text = ""
            labelCurrentQuestionDesc.alpha = 0
            pickerViewQuiz.alpha = 0
            buttonSubmit.alpha = 0
            
            //show labels
            viewIsCompletedTrue.alpha = 1
            didSelectItemAtCollView_UpdateResultLabels()
            
            //clear quizIDfromcollview
            QuizIDFromCollView = 0
            
            //refresh collview
            collectionViewQuiz.reloadData()
            
        } else {
            //update button label
            if currentQuestionID == QuizArrFiltered[QuizIDFromCollView - 1].questions.count - 2 {
                self.buttonSubmit.setTitle("Submit", for: .normal)
            }
            
            //update numberOfCorrect
            if selectedAnswer.1 {
                numberOfCorrect += 1
                print("Correct")
            }
            //show next question
            currentQuestionID += 1
            labelCurrentQuestionDesc.alpha = 1
            pickerViewQuiz.alpha = 1
            labelCurrentQuestionDesc.text = "Question \(currentQuestionID + 1): " +  QuizArrFiltered[QuizIDFromCollView - 1].questions[currentQuestionID].questionDesc
            pickerViewQuiz.reloadAllComponents()
        }
    }
    var selectedAnswer = ("",false)
    var currentQuestionID = 0
    var numberOfCorrect = 0
    var QuizArrAll = [Quiz]()
    var QuizArrFiltered = [Quiz]()
    var QuizIDFromCollView = 0
    @IBOutlet weak var viewIsCompletedFalse: UIView!
    @IBOutlet weak var viewIsCompletedTrue: UIView!
    @IBOutlet weak var labelCompletedAt: UILabel!
    @IBOutlet weak var labelPrize: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelQuizDesc: UILabel!
    @IBOutlet weak var labelReminderWhenIsCompletedIsNil: UILabel!
    @IBOutlet weak var navItemUserName: UINavigationItem!
    @IBAction func buttonDidTouchUpInside_SignOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // MARK: - Changes on Main.storyboard (Updated navigation controller for loginVC, value: loginVC)
        let navController = storyboard.instantiateViewController(withIdentifier: "loginNC")
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoad_TransparentNavBar()
        viewDidLoad_PopulateCurrentUserName()
        viewDidLoad_UpdateLabelText()
        viewDidLoad_PrepareQuizArrAll()
        viewDidLoad_PrepareQuizArrFiltered()
        DBHelperQuiz.dbHelperQuiz.prepareDatabase()
        DBHelperQuiz.dbHelperQuiz.createTable()
        print("DB prepared")
        print("viewDidLoad")
    }
}

//User Interface Configuration
extension QuizViewController {
    func viewDidLoad_TransparentNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    func disableSearchTab() {
        let searchVC = SearchViewController()
        searchVC.tabBarItem.isEnabled = false
    }
}


//Content Loading & Data Preparation
extension QuizViewController {
    func currentUserEmail() -> String {
        // TODO: - Uncomment the following lines to grab userDefault info
        //let userDefaults = UserDefaults.standard
        //return userDefaults.string(forKey: "lastUser")!
        return "test@gmail.com"
    }
    func viewDidLoad_PrepareQuizArrFiltered() {
        for quiz in QuizArrAll {
            // TODO: - Add logic to filter/search
            if true {
                QuizArrFiltered.append(quiz)
            }
        }
    }
    func viewDidLoad_PrepareQuizArrAll() {
        QuizArrAll.append(
            Quiz.init(quizID: 1, quizDesc: "Swift", questions: [
                Question.init(questionID: 1, questionDesc: "Swift is a type-safe language. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 2, questionDesc: "Tuple is a collection type in Swift. T/F?", answerOptions: [("True", false), ("False", true)]),
                Question.init(questionID: 3, questionDesc: "Which of the following can be used to clear an array?", answerOptions: [(".removeAll()",true), (".clear()", false), (".cleanAll()", false)]),
                Question.init(questionID: 4, questionDesc: "Structs are value type and classes are reference type. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 5, questionDesc: "Which of the following is NOT an access modifier in Swift?", answerOptions: [("Private", false),("Open", false),("File-private", false),("let", true)])
            ])
        )
        QuizArrAll.append(
            Quiz.init(quizID: 2, quizDesc: "C Language", questions: [
                Question.init(questionID: 1, questionDesc: "Swift is a type-safe language. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 2, questionDesc: "Tuple is a collection type in Swift. T/F?", answerOptions: [("True", false), ("False", true)]),
                Question.init(questionID: 3, questionDesc: "Which of the following can be used to clear an array?", answerOptions: [(".removeAll()",true), (".clear()", false), (".cleanAll()", false)]),
                Question.init(questionID: 4, questionDesc: "Structs are value type and classes are reference type. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 5, questionDesc: "Which of the following is NOT an access modifier in Swift?", answerOptions: [("Private", false),("Open", false),("File-private", false),("let", true)])
            ])
        )
        QuizArrAll.append(
            Quiz.init(quizID: 3, quizDesc: "JavaScript", questions: [
                Question.init(questionID: 1, questionDesc: "Swift is a type-safe language. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 2, questionDesc: "Tuple is a collection type in Swift. T/F?", answerOptions: [("True", false), ("False", true)]),
                Question.init(questionID: 3, questionDesc: "Which of the following can be used to clear an array?", answerOptions: [(".removeAll()",true), (".clear()", false), (".cleanAll()", false)]),
                Question.init(questionID: 4, questionDesc: "Structs are value type and classes are reference type. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 5, questionDesc: "Which of the following is NOT an access modifier in Swift?", answerOptions: [("Private", false),("Open", false),("File-private", false),("let", true)])
            ])
        )
        QuizArrAll.append(
            Quiz.init(quizID: 4, quizDesc: "Python", questions: [
                Question.init(questionID: 1, questionDesc: "Swift is a type-safe language. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 2, questionDesc: "Tuple is a collection type in Swift. T/F?", answerOptions: [("True", false), ("False", true)]),
                Question.init(questionID: 3, questionDesc: "Which of the following can be used to clear an array?", answerOptions: [(".removeAll()",true), (".clear()", false), (".cleanAll()", false)]),
                Question.init(questionID: 4, questionDesc: "Structs are value type and classes are reference type. T/F?", answerOptions: [("True", true), ("False", false)]),
                Question.init(questionID: 5, questionDesc: "Which of the following is NOT an access modifier in Swift?", answerOptions: [("Private", false),("Open", false),("File-private", false),("let", true)])
            ])
        )
    }
    func didSelectCollOrTable_HideLabelText() {
        labelReminderWhenIsCompletedIsNil.text = ""
    }
    func viewDidLoad_UpdateLabelText() {
        labelReminderWhenIsCompletedIsNil.text = "Select a completed quiz to view results or select a new quiz to start."
        labelReminderWhenIsCompletedIsNil.textColor = .darkGray
    }
    func viewDidLoad_PopulateCurrentUserName() {
        // TODO: - Uncomment the following two lines to populate user name in the nav bar
        CurrentUser.user.updateCurrentUserName()
        navItemUserName.title = CurrentUser.user.name
        //navItemUserName.title = "Test User"
    }
}

//PickerView
extension QuizViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].answerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedAnswer = QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].answerOptions[row]
        return QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].answerOptions[row].0
    }
    
    
}
//CollectionView
extension QuizViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuizArrFiltered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quizcellcoll = collectionView.dequeueReusableCell(withReuseIdentifier: "quizcellcoll", for: indexPath) as! QuizCollectionViewCell
        
        print("QuizID = \(indexPath.section + 1)")
        if DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: NSNumber(value: indexPath.section + 2), userEmail: currentUserEmail() as NSString) {
            quizcellcoll.imageViewCompleted.image = UIImage(systemName: "checkmark.circle.fill")
            quizcellcoll.imageViewCompleted.tintColor = .green
        } else {
            quizcellcoll.imageViewCompleted.image = UIImage(systemName: "circlebadge")
            quizcellcoll.imageViewCompleted.tintColor = .red
        }
        
        quizcellcoll.imageViewThumbnail.image = UIImage(named: "Quiz-" + QuizArrFiltered[indexPath.row].quizDesc)
        //quizcellcoll.imageViewThumbnail.contentMode = .scaleToFill
        quizcellcoll.imageViewThumbnail.layer.cornerRadius = 14
        quizcellcoll.clipsToBounds = true
        quizcellcoll.labelQuizDescription.text = QuizArrFiltered[indexPath.row].quizDesc
        
        quizcellcoll.labelQuizID.text = "Quiz \(QuizArrFiltered[indexPath.row].quizID)"
        return quizcellcoll
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        labelReminderWhenIsCompletedIsNil.text = ""
        print("QuizID = \(indexPath.row + 1)")
        let quizIsCompleted : Bool = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: NSNumber(value: indexPath.row + 1), userEmail: currentUserEmail() as NSString)
        
        if quizIsCompleted {
            didSelectItemAtCollView_UpdateResultLabels()
            self.viewIsCompletedTrue.alpha = 1
            self.viewIsCompletedFalse.alpha = 0
            self.pickerViewQuiz.alpha = 0
            self.labelCurrentQuestionDesc.alpha = 0
            self.buttonSubmit.alpha = 0
        } else {
            self.viewIsCompletedTrue.alpha = 0
            self.viewIsCompletedFalse.alpha = 1
            self.viewIsCompletedFalse.alpha = 1
            self.pickerViewQuiz.alpha = 1
            self.labelCurrentQuestionDesc.alpha = 1
            currentQuestionID = 0
            labelCurrentQuestionDesc.text = "Question \(currentQuestionID + 1): " +  QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].questionDesc
            self.buttonSubmit.alpha = 1
            disableSearchTab()
        }
        
        self.QuizIDFromCollView = indexPath.row + 1
        print("QuizID = \(indexPath.row + 1)")
    }
}

//UIView - Results
extension QuizViewController {
    func didSelectItemAtCollView_UpdateResultLabels() {
        print(DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: (QuizIDFromCollView + 1) as NSNumber, userEmail: currentUserEmail() as NSString) as Bool)
        let quizResult : QuizResult = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: (QuizIDFromCollView + 1) as NSNumber, userEmail: currentUserEmail() as NSString)
        var CompletedAt = quizResult.completedAt
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let CompletedAtDate = dateFormatter.date(from: CompletedAt)
        CompletedAt = dateFormat(date: CompletedAtDate!)
        
        labelCompletedAt.text = CompletedAt
        
        labelResult.text = "\(quizResult.numberOfCorrect) / \(QuizArrAll[QuizIDFromCollView].questions.count)"
        
        labelPrize.text = "$\(quizResult.numberOfCorrect * 2).00"
        
        labelQuizDesc.text = "\(QuizArrAll[QuizIDFromCollView].quizDesc)"
    }
    func dateFormat(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        let hourFormatter = DateFormatter()
        hourFormatter.timeZone = TimeZone(abbreviation: "EST")
        hourFormatter.dateFormat = "HH"
        
        let minuteFormatter = DateFormatter()
        minuteFormatter.timeZone = TimeZone(abbreviation: "EST")
        minuteFormatter.dateFormat = "mm"
        
        var hourString = hourFormatter.string(from: date)
        let hourInt = Int(hourString)
        let minuteString = minuteFormatter.string(from: date)
        
        if hourInt! > 12 {
             hourString = "\(String(hourInt!-12)):\(minuteString) PM"
        } else if hourInt! == 12 {
            hourString = "\(String(hourInt!)):\(minuteString) PM"
        } else if hourInt! == 0 {
            hourString = "\(String(hourInt! + 12)):\(minuteString) AM"
        } else {
            hourString = "\(String(hourInt!)):\(minuteString) AM"
        }
        
        return dateFormatter.string(from: date) + " " + hourString
        
    }
}

//TableView
extension QuizViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].answerOptions.count
        return 1
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let quizcelltable = tableView.dequeueReusableCell(withIdentifier: "quizcelltable", for: indexPath) as! QuizTableViewCell
        //quizcelltable.labelAnswerOptions.text = QuizArrFiltered[QuizIDFromCollView].questions[indexPath.section].answerOptions[indexPath.row].0

        return quizcelltable
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        print("QuizID: \(QuizIDFromCollView)")
        //return QuizArrFiltered[QuizIDFromCollView].questions.count
        return 1
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return QuizArrFiltered[QuizIDFromCollView].questions[currentQuestionID].questionDesc
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedCell : QuizTableViewCell = tableView.cellForRow(at: indexPath as IndexPath)! as! QuizTableViewCell
        selectedCell.labelAnswerOptions.textColor = .red
    }

    func buttonSubmitAnswersDidTouchUpInside() {
//        if AnswerFromTableView_Correct.count != AnswerFromTableView_User.count {
//
//            // TODO: - Alert - complete the quiz
//            print("Pleaes finish the quiz before submitting it.")
//        } else {
//            let quizID = QuizArrFiltered[QuizIDFromCollView] as! NSNumber
//            let isCompleted = 1 as! NSNumber
//            let userEmail = currentUserEmail() as! NSString
//
//            //get current data in yyyyMMddHHmmss
//            let dateformatter = DateFormatter()
//            let currentTime = Date()
//            dateformatter.timeZone = TimeZone(abbreviation: "EST")
//            dateformatter.dateFormat = "yyyyMMddHHmmss"
//            let completedAt = dateformatter.string(from: currentTime) as! NSString
//
//
//            DBHelperQuiz.dbHelperQuiz.createQuizResult(quizID: quizID, isCompleted: isCompleted, numberOfCorrect: numberOfCorrect as! NSNumber, userEmail: userEmail, completedAt: completedAt)
//
//            print("Results saved to DB.")
//            currentQuestionID += 1
//        }
    }
}


class Quiz {
    var quizID : Int
    var quizDesc : String
    var questions : [Question]
    init(quizID : Int, quizDesc : String, questions : [Question]) {
        self.quizID = quizID
        self.quizDesc = quizDesc
        self.questions = questions
    }
}
class Question {
    var questionID : Int
    var questionDesc : String
    var answerOptions : [(String, Bool)]
    init(questionID : Int, questionDesc : String, answerOptions : [(String, Bool)]) {
        self.questionID = questionID
        self.questionDesc = questionDesc
        self.answerOptions = answerOptions
    }
}
class QuizResult {
    var quizID : Int
    var isCompleted : Bool
    var numberOfCorrect : Int
    var userEmail : String //email address
    var completedAt : String //yyyyMMddHHmmss
    
    init(quizID : Int, isCompleted : Bool, numbOfCorrect : Int, userEmail : String, completedAt : String) {
        self.quizID = quizID
        self.isCompleted = isCompleted
        self.numberOfCorrect = numbOfCorrect
        self.userEmail = userEmail
        self.completedAt = completedAt
    }
}

import SQLite3
class DBHelperQuiz {
    static var dbHelperQuiz = DBHelperQuiz()
    var dbpointer : OpaquePointer?
    var retrivedQuizResults = [QuizResult]()
    
    //create/prepare database
    func prepareDatabase() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("QuizResult.sqlite")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK {
            print("Error at prepareDatabase()")
        } else {
            print("SQLite3 Database is ready")
        }
    }
    var QuizSQL = ""
    //create table
    func createTable() {
        QuizSQL = "CREATE TABLE IF NOT EXISTS QUIZ_RESULT (DBID INTEGER PRIMARY KEY AUTOINCREMENT, quizID INTEGER, isCompleted INTEGER, numberOfCorrect INTEGER, userEmail TEXT, completedAt TEXT)"
        if sqlite3_exec(dbpointer, QuizSQL, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error. Cannot create table. SQLite3: \(error)")
        }
        QuizSQL = ""
    }
    
    //CRUD - Create (insert)
    func createQuizResult(quizID : NSNumber, isCompleted : NSNumber, numberOfCorrect : NSNumber, userEmail : NSString, completedAt : NSString) {
        var statement : OpaquePointer?
        QuizSQL = "INSERT INTO QUIZ_RESULT (quizID, isCompleted, numberOfCorrect, userEmail, completedAt) VALUES (\(quizID),\(isCompleted),\(numberOfCorrect),'\(userEmail)','\(completedAt)'"
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error. Cannot prepare SQL query. SQLite3: \(error)")
        } else {
            if sqlite3_bind_int(statement, 1, quizID.int32Value) != SQLITE_OK {
                let error = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error. Cannot save name. SQLite3: \(error)")
            } else {
                if sqlite3_bind_int(statement, 2, isCompleted.int32Value) != SQLITE_OK {
                    let error = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("Error. Cannot save name. SQLite3: \(error)")
                } else {
                    if sqlite3_bind_int(statement, 3, numberOfCorrect.int32Value) != SQLITE_OK {
                        let error = String(cString: sqlite3_errmsg(dbpointer)!)
                        print("Error. Cannot save name. SQLite3: \(error)")
                    } else {
                        if sqlite3_bind_text(statement, 4, userEmail.utf8String, -1, nil) != SQLITE_OK {
                            let error = String(cString: sqlite3_errmsg(dbpointer)!)
                            print("Error. Cannot save name. SQLite3: \(error)")
                        } else {
                            if sqlite3_bind_text(statement, 5, completedAt.utf8String, -1, nil) != SQLITE_OK {
                                let error = String(cString: sqlite3_errmsg(dbpointer)!)
                                print("Error. Cannot save name. SQLite3: \(error)")
                            } else {
                                print("Quiz Result Data Saved.")
                            }
                        }
                    }
                }
            }
        }
    }
    
    //CRUD - Retrieve
    func retrieveQuizResult(quizID : NSNumber, userEmail : NSString) -> QuizResult {
        
        QuizSQL = "SELECT * FROM QUIZ_RESULT WHERE (quizID = \(quizID) AND userEmail = '\(userEmail)')"
        //QuizSQL = "SELECT * FROM QUIZ_RESULT"
        
        var statement : OpaquePointer?
        var quizResult : QuizResult?
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let quizID = Int(sqlite3_column_int(statement, 1))
                let isCompletedInt = Int(sqlite3_column_int(statement, 2))
                var isCompleted = false
                if isCompletedInt == 1 {
                    isCompleted = true
                }
                let numberOfCorrect = Int(sqlite3_column_int(statement, 3))
                let userEmail = String(cString: (sqlite3_column_text(statement, 4)))
                let completedAt = String(cString: sqlite3_column_text(statement, 5))
                
                quizResult = QuizResult(quizID: quizID, isCompleted: isCompleted, numbOfCorrect: numberOfCorrect, userEmail: userEmail, completedAt: completedAt)
            }
        } else {
            print("Error in query.")
            // TODO: -
            //quizResult = QuizResult(quizID: 1, isCompleted: true, numbOfCorrect: 1, userEmail: "Error_test@gmail.com", completedAt: "20220617140811")
        }
        return quizResult!
    }
    
    func retrieveQuizResult(quizID : NSNumber, userEmail : NSString) -> Bool {
        var isCompleted = false
        QuizSQL = "SELECT * FROM QUIZ_RESULT WHERE (quizID = \(quizID) AND userEmail = '\(userEmail)')"
        //QuizSQL = "SELECT * FROM QUIZ_RESULT"
        var statement : OpaquePointer?
        //var quizResult : QuizResult?
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                isCompleted = true
            }
        } else {
            print("Error in query.")
        }
        return isCompleted
    }
}
