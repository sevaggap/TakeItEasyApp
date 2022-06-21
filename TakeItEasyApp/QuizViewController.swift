//
//  QuizViewController.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/19/22.
//

import UIKit

// TODO: -KEYCHAIN

class QuizViewController: UIViewController {

    @IBOutlet weak var labelSelectionReminder: UILabel!
    var isFiltered = false
    @IBOutlet weak var buttonFilter: UIButton!
    @IBAction func buttonFilter_didTouchUpInside(_ sender: Any) {
        buttonFilter_didTouchUpInside()
    }
    var isSearching = false
    @IBOutlet weak var searchBarQuiz: UISearchBar!
    @IBOutlet weak var labelPrizeAmount: UILabel!
    @IBOutlet weak var labelQuizDesc: UILabel!
    @IBOutlet weak var labelCompletedAt: UILabel!
    @IBOutlet weak var labelNumberOfCorrect: UILabel!
    @IBOutlet weak var labelDownload: UILabel!
    @IBOutlet weak var imageViewDownloadBg: UIImageView!
    @IBOutlet weak var labelCurrentQuestion: UILabel!
    @IBOutlet weak var pickerViewQuiz: UIPickerView!
    @IBOutlet weak var buttonNextQuestionOrSubmit: UIButton!
    @IBAction func buttonNextQuestionOrSubmit_didTouchUpInside(_ sender: Any) {
        buttonNextQuestionOrSubmit_didTouchUpInside()
    }
    @IBOutlet weak var collectionViewQuiz: UICollectionView!
    @IBOutlet weak var containerViewQuizPicker: UIView!
    @IBOutlet weak var containerViewResults: UIView!
    
    
    /// Arr to store all quiz objects
    var QuizArrAll = [Quiz]()
    /// Temp arr to store filtered or searched quiz objects
    var QuizArr = [Quiz]()
    
    /// Temp str to store the email address of the user currently logged in
    var currentUserEmail = ""
    
    /// Temp int to store the quiz id of selected quiz
    var currentQuizID = 1
    /// Temp int to store the question id of selected quiz
    var currentQuestionID = 1
    /// Temp int to store # of correct answers
    var numOfCorrect = 0
    /// Temp tuple to store selected quiz response
    var selectedAnswer = ("", false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoad_TransparentNavBar()
        viewDidLoad_GetCurrentUserInfo()
        viewDidLoad_PrepareQuizData()
        viewDidLoad_PrepareDatabaseAndTables()
    }
}

// MARK: PART 1. viewDidLoad functions
extension QuizViewController {
    /// Update navbar appearance to make it transparent
    func viewDidLoad_TransparentNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    
    /// Get the name & email of user currently logged in
    func viewDidLoad_GetCurrentUserInfo() {
        CurrentUser.user.updateCurrentUserName()
        print("Current user: \(CurrentUser.user.name!)")
        //navigationItem_Username.title = CurrentUser.user.name!
        let userDefaults = UserDefaults.standard
        currentUserEmail = userDefaults.string(forKey: "lastUser")!
    }
    
    func viewDidLoad_PrepareQuizData() {
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
        QuizArr = QuizArrAll
    }
    
    func viewDidLoad_PrepareDatabaseAndTables(){
        DBHelperQuiz.dbHelperQuiz.prepareDatabase()
        DBHelperQuiz.dbHelperQuiz.prepareTableQuizResult()
    }
}


// MARK: PART 2. UICollectionView Load Data
extension QuizViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// UICollectionView Number of Items in Section
    /// - Returns: the count of elements in QuizArr
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuizArr.count
    }
    
    
    /// UICollectionView Cell for Item at
    /// - Returns: Quiz cell with configuration of progress (image), quiz (image), quiz desc (label) & quiz id (label)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quizCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCollectionViewCell", for: indexPath) as! QuizCollectionViewCell
        
        //Configure progress image according to quizresult.iscompleted
        let quizIDOfCell = QuizArr[indexPath.row].quizID
        
        let isQuizCompleted : Bool = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: quizIDOfCell as NSNumber, userEmail: currentUserEmail as NSString)
        if isQuizCompleted {
            quizCollectionViewCell.imageViewQuizProgress.image = UIImage(systemName: "checkmark.circle.fill")
            quizCollectionViewCell.imageViewQuizProgress.tintColor = .green
        } else {
            quizCollectionViewCell.imageViewQuizProgress.image = UIImage(systemName: "circlebadge")
            quizCollectionViewCell.imageViewQuizProgress.tintColor = .red
        }
        
        //configure thumbnail image
        quizCollectionViewCell.imageViewQuizImage.image = UIImage(named: "Quiz-\(QuizArr[indexPath.row].quizDesc)")
        quizCollectionViewCell.imageViewQuizImage.layer.cornerRadius = 14
        
        //configure labels
        quizCollectionViewCell.labelQuizDesc.text = QuizArr[indexPath.row].quizDesc
        quizCollectionViewCell.labelQuizID.text = "Quiz ID: \(QuizArr[indexPath.row].quizID)"
        
        return quizCollectionViewCell
    }
    
    
    /// UICollectionView didSelectItemAt - Enable either UIViewResult or UIViewQuizPicker according quizresult.iscompleted. And show alerts before a quiz starts.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quizIDOfCell = QuizArr[indexPath.row].quizID
        let isQuizCompleted : Bool = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: quizIDOfCell as NSNumber, userEmail: currentUserEmail as NSString)
        
        if isQuizCompleted {
            
            hidePickerView()
            hideLabelSelectionReminder()
            showResults(quizID: quizIDOfCell)
            unhideResult()
            
        } else {
            
            //Alert before quiz starts. Continue => disable UIViewResult/tabs enable pickerview.Disable userinteraction for collectionview Cancel -> nil
            
            let alertBeforeQuiz = UIAlertController(title: "Reminder", message: "You’re about to start quiz: \(QuizArr[indexPath.row].quizDesc). During the quiz you won’t be able to switch between tabs. Please select Continue or Cancel.", preferredStyle: .alert)
            let alertActionContinue = UIAlertAction(title: "Continue", style: .default, handler: { _ in
                self.labelSelectionReminder.alpha = 0
                self.currentQuizID = quizIDOfCell
                self.currentQuestionID = 1
                self.hideResult()
                self.tabBarController?.tabBar.isHidden = true
                self.collectionViewQuiz.allowsSelection = false
                self.collectionViewQuiz.alpha = 0.4
                self.unhidePickerView()
                self.pickerViewQuiz.reloadAllComponents()
                self.labelCurrentQuestion.text = "Question \(self.currentQuestionID): " +  self.QuizArr[self.currentQuizID - 1].questions[self.currentQuestionID - 1].questionDesc
            })
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertBeforeQuiz.addAction(alertActionContinue)
            alertBeforeQuiz.addAction(alertActionCancel)
            present(alertBeforeQuiz, animated: true)
        }
    }
    
}

// MARK: PART 3. UIPickerView Load Data
extension QuizViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    /// UIPickerView Number of Rows in Component (Number of answer options)
    /// - Returns: Number of answer options
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return QuizArr[currentQuizID - 1].questions[currentQuestionID - 1].answerOptions.count
    }
    
    /// UIPickerView Title for Row
    /// - Returns: Question description of current question in current quiz
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        labelCurrentQuestion.text = QuizArr[currentQuizID - 1].questions[currentQuestionID - 1].questionDesc
        return QuizArr[currentQuizID - 1].questions[currentQuestionID - 1].answerOptions[row].0
    }
    
    /// UIPickerView didSelectRow -> Temporarily save the user's answer
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAnswer = QuizArr[currentQuizID - 1].questions[currentQuestionID - 1].answerOptions[row]
    }
    
    func buttonNextQuestionOrSubmit_didTouchUpInside() {
        if currentQuestionID == QuizArr[currentQuizID - 1].questions.count {
            //update # of correct
            if selectedAnswer.1 {
                numOfCorrect += 1
            }
            print("Correct.")
            
            //save data in db
            //get current data in yyyyMMddHHmmss
            let dateformatter = DateFormatter()
            let currentTime = Date()
            dateformatter.timeZone = TimeZone(abbreviation: "EST")
            dateformatter.dateFormat = "yyyyMMddHHmmss"
            let completedAt = dateformatter.string(from: currentTime)
            
            //saved quiz result in DB
            DBHelperQuiz.dbHelperQuiz.createQuizResult(quizID: currentQuizID as! NSNumber, isCompleted: 1 as! NSNumber, numberOfCorrect: numOfCorrect as! NSNumber, userEmail: currentUserEmail as! NSString, completedAt: completedAt as! NSString)
            
            print("Result Saved in DB.")

            
            //hide
            containerViewQuizPicker.alpha = 0
            labelCurrentQuestion.text = ""
            //TODO: - Enable FIRST-OPEN REMINDER MESSAGE
            //refresh
            collectionViewQuiz.allowsSelection = true
            collectionViewQuiz.alpha = 1
            collectionViewQuiz.reloadData()
            //show result
            containerViewResults.alpha = 1
            
            
            showResults(quizID: currentQuizID)
            
            //clear temp values
            /// Temp int to store the quiz id of selected quiz
            currentQuizID = 1
            /// Temp int to store the question id of selected quiz
            currentQuestionID = 1
            /// Temp int to store # of correct answers
            numOfCorrect = 0
            /// Temp tuple to store selected quiz response
            selectedAnswer = ("", false)
            
        } else {
            //update button label
            if currentQuestionID == QuizArr[currentQuizID - 1].questions.count - 1 {
                self.buttonNextQuestionOrSubmit.setTitle("Submit", for: .normal)
            }
            
            if selectedAnswer.1 {
                numOfCorrect += 1
            }
            //show next question
            currentQuestionID += 1
            labelCurrentQuestion.alpha = 1
            containerViewQuizPicker.alpha = 1
            labelCurrentQuestion.text = "Question \(currentQuestionID): " +  QuizArr[currentQuizID - 1].questions[currentQuestionID - 1].questionDesc
            pickerViewQuiz.reloadAllComponents()
        }
    }
}

// MARK: PART 4. QuizResultCircleView Load Data
extension QuizViewController {
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
    func showResults(quizID : Int) {
        let quizResult : QuizResult = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: quizID as! NSNumber, userEmail: self.currentUserEmail as! NSString)
        let numberOfTotal = QuizArr[quizID - 1].questions.count
        let numberOfCorrect = quizResult.numberOfCorrect
        var completedAtStr = quizResult.completedAt
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let CompletedAtDate = dateFormatter.date(from: completedAtStr)
        completedAtStr = dateFormat(date: CompletedAtDate!)
        
        
        showResultCircle(numberOfCorrect: CGFloat(numberOfCorrect), numberOfTotal: CGFloat(numberOfTotal))
        showResultLabels(quizID: quizID, numberOfCorrect: numberOfCorrect, numberOfTotal: numberOfTotal, completedAt: completedAtStr)
        
    }
    func showResultLabels(quizID: Int, numberOfCorrect : Int, numberOfTotal : Int, completedAt : String) {
        labelNumberOfCorrect.text = "\(numberOfCorrect) / \(numberOfTotal)"
        labelPrizeAmount.text = "$\(numberOfCorrect * 2).00"
        labelQuizDesc.text = QuizArr[quizID - 1].quizDesc
        labelCompletedAt.text = "Completed at: \(completedAt)"
        
        if numberOfCorrect != 0 {
            imageViewDownloadBg.alpha = 1
            labelDownload.alpha = 1
        } else {
            imageViewDownloadBg.alpha = 1
            labelDownload.alpha = 1
        }
    }
    func showResultCircle(numberOfCorrect : CGFloat, numberOfTotal : CGFloat) {
        var bezierPath_NumberOfCorrect = UIBezierPath(arcCenter: containerViewQuizPicker.center, radius: 90, startAngle: -.pi / 2, endAngle: .pi * (2 - 1 / 2) * CGFloat(numberOfCorrect / numberOfTotal), clockwise: true)
        
        if numberOfCorrect == 0 {
            bezierPath_NumberOfCorrect = UIBezierPath(arcCenter: containerViewQuizPicker.center, radius: 90, startAngle: -.pi / 2, endAngle: -.pi / 2 + .pi / 16, clockwise: true)
        }
        
        let bezierPath_NumberOfQuestion = UIBezierPath(arcCenter: containerViewQuizPicker.center, radius: 90, startAngle: -.pi / 2, endAngle: .pi * (2 - 1 / 2), clockwise: true)
        
        let shapeCircle_NumberOfQuestion = CAShapeLayer()
        shapeCircle_NumberOfQuestion.path = bezierPath_NumberOfQuestion.cgPath
        shapeCircle_NumberOfQuestion.fillColor = UIColor.clear.cgColor
        shapeCircle_NumberOfQuestion.lineWidth = 10
        shapeCircle_NumberOfQuestion.strokeColor = UIColor(red: 250.0 / 255.0, green: 223.0 / 255.0, blue: 112.0 / 255.0, alpha: 1.0).cgColor //yellow
        containerViewResults.layer.addSublayer(shapeCircle_NumberOfQuestion)
        
        let shapeStroke_NumberOfCorrect = CAShapeLayer()
        shapeStroke_NumberOfCorrect.path = bezierPath_NumberOfCorrect.cgPath
        shapeStroke_NumberOfCorrect.strokeEnd = 0
        shapeStroke_NumberOfCorrect.lineWidth = 14
        shapeStroke_NumberOfCorrect.strokeColor = UIColor(red: 88.0 / 255.0, green: 86.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0).cgColor //purple
        shapeStroke_NumberOfCorrect.fillColor = UIColor.clear.cgColor
        containerViewResults.layer.addSublayer(shapeStroke_NumberOfCorrect)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.7
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shapeStroke_NumberOfCorrect.add(animation, forKey: "animation")
    }
}

// MARK: PART 5. SEARCHBAR FUNCTIONALITIES
extension QuizViewController : UISearchBarDelegate {
    
    func hidePickerView() {
        containerViewQuizPicker.alpha = 0
    }
    func unhidePickerView() {
        containerViewQuizPicker.alpha = 1
    }
    func hideResult() {
        containerViewResults.alpha = 0
    }
    func unhideResult() {
        containerViewResults.alpha = 1
    }
    func hideLabelSelectionReminder() {
        labelSelectionReminder.alpha = 0
    }
    func unhideLabelSelectionReminder() {
        labelSelectionReminder.alpha = 1
    }
    func hideLabelDownloadReminder() {
        labelDownload.alpha = 0
    }
    func unhideLabelDownloadReminder() {
        labelDownload.alpha = 1
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        QuizArr.removeAll()
        print("Searching")
        
        unhideLabelSelectionReminder()
        hideResult()
        hidePickerView()
        
        if searchText == "" || searchText == " " {
            isSearching = false
            QuizArr = QuizArrAll
            collectionViewQuiz.reloadData()
        } else {
            for quiz in QuizArrAll {
                if quiz.quizDesc.lowercased().contains(searchText.lowercased()) {
                    QuizArr.append(quiz)
                }
                isSearching = true
            }
            print(QuizArr)
            collectionViewQuiz.reloadData()
        }
    }
}

// MARK: PART 6. FILTER FUNCTIONALITIES
extension QuizViewController {
    func buttonFilter_didTouchUpInside(){
        unhideLabelSelectionReminder()
        hideResult()
        hidePickerView()
        
        isFiltered = !isFiltered
        
        if isFiltered {
            //update button image to fill
            buttonFilter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
            
            //remove completed quizzes
            QuizArr.removeAll()
            for quiz in QuizArrAll {
                let isCompleted : Bool = DBHelperQuiz.dbHelperQuiz.retrieveQuizResult(quizID: quiz.quizID as NSNumber, userEmail: currentUserEmail as NSString)
                print("quiz \(quiz.quizID) is \(isCompleted)")
                if !isCompleted {
                    QuizArr.append(quiz)
                }
            }
            collectionViewQuiz.reloadData()
        } else {
            //update button image to non-fill
            buttonFilter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            
            //show all quizzes
            QuizArr = QuizArrAll
            collectionViewQuiz.reloadData()
        }
    }
}

import SQLite3
class DBHelperQuiz {
    static var dbHelperQuiz = DBHelperQuiz()
    var dbpointer : OpaquePointer?
    var retrivedQuizResults = [QuizResult]() //temp arr to store CRUD-R/U results
    var QuizSQL = "" //temp str for sql query statements
    
    
    /// Obtain SQLite3 error message and print it in the console
    func printSQLiteErrorMsg() {
        let error = String(cString: sqlite3_errmsg(dbpointer)!)
        print("Error. SQLite3: \(error)")
    }
    
    /// Create sqlite file if not exists
    func prepareDatabase() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("QuizResult.sqlite")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            print("SQLite3 Database is ready")
        }
    }
    
    /// Create the table for Quiz Results in db if not exists
    func prepareTableQuizResult() {
        QuizSQL = "CREATE TABLE IF NOT EXISTS QUIZ_RESULT (quizID INTEGER, isCompleted INTEGER, numberOfCorrect INTEGER, userEmail TEXT, completedAt TEXT)"
        if sqlite3_exec(dbpointer, QuizSQL, nil, nil, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            print("Table QUIZ_RESULT is ready.")
        }
    }
    
    
    //CRUD - Create (insert)
    func createQuizResult(quizID : NSNumber, isCompleted : NSNumber, numberOfCorrect : NSNumber, userEmail : NSString, completedAt : NSString) {
        var statement : OpaquePointer?
        QuizSQL = "INSERT INTO QUIZ_RESULT (quizID, isCompleted, numberOfCorrect, userEmail, completedAt) VALUES (?, ?, ?, ?, ?);"
        //QuizSQL = "INSERT INTO QUIZ_RESULT (quizID, isCompleted, numberOfCorrect, userEmail, completedAt) VALUES (\(quizID),\(isCompleted),\(numberOfCorrect),'\(userEmail)',\(completedAt))"
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) != SQLITE_OK {
            printSQLiteErrorMsg()
        } else {
            if sqlite3_bind_int(statement, 1, quizID.int32Value) != SQLITE_OK {
                printSQLiteErrorMsg()
            } else {
                if sqlite3_bind_int(statement, 2, isCompleted.int32Value) != SQLITE_OK {
                    printSQLiteErrorMsg()
                } else {
                    if sqlite3_bind_int(statement, 3, numberOfCorrect.int32Value) != SQLITE_OK {
                        printSQLiteErrorMsg()
                    } else {
                        if sqlite3_bind_text(statement, 4, userEmail.utf8String, -1, nil) != SQLITE_OK {
                            printSQLiteErrorMsg()
                        } else {
                            if sqlite3_bind_text(statement, 5, completedAt.utf8String, -1, nil) != SQLITE_OK {
                                printSQLiteErrorMsg()
                            } else {
                                if sqlite3_step(statement) == SQLITE_DONE {
                                    print("Quiz Result Data Saved.")
                                }
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
        
        var statement : OpaquePointer?
        var quizResult : QuizResult?
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let quizID = Int(sqlite3_column_int(statement, 0))
                let isCompletedInt = Int(sqlite3_column_int(statement, 1))
                var isCompleted = false
                if isCompletedInt == 1 {
                    isCompleted = true
                }
                let numberOfCorrect = Int(sqlite3_column_int(statement, 2))
                let userEmail = String(cString: (sqlite3_column_text(statement, 3)))
                let completedAt = String(cString: sqlite3_column_text(statement, 4))
                
                quizResult = QuizResult(quizID: quizID, isCompleted: isCompleted, numbOfCorrect: numberOfCorrect, userEmail: userEmail, completedAt: completedAt)
            }
            else {
                print("SQLite3 OK but no results found.")
            }
        } else {
            printSQLiteErrorMsg()
            // TODO: -
            //quizResult = QuizResult(quizID: 1, isCompleted: true, numbOfCorrect: 1, userEmail: "Error_test@gmail.com", completedAt: "20220617140811")
        }
        return quizResult!
    }
    
    func retrieveQuizResult(quizID : NSNumber, userEmail : NSString) -> Bool {
        var isCompleted = false
        QuizSQL = "SELECT * FROM QUIZ_RESULT WHERE (quizID = \(quizID) AND userEmail = '\(userEmail)')"
        var statement : OpaquePointer?
        
        if sqlite3_prepare(dbpointer, QuizSQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                isCompleted = true
            }
        } else {
            printSQLiteErrorMsg()
        }
        return isCompleted
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
