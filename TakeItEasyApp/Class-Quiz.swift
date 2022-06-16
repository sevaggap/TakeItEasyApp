//
//  Class-Quiz.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/14/22.
//

import Foundation

class Quiz_MasterData {
    //this class is matched with master data table used to store quiz info such as id, questions and answers.
    var quizID : Int
    var quizDesc : String
    var quizQuestionID : Int
    var quizQuestionDesc : String
    var quizAnswerID : Int
    var quizAnswerDesc : String
    var answerIsCorrect : Bool
    
    init(
        quizID : Int,
        quizDesc : String,
        quizQuestionID : Int,
        quizQuestionDesc : String,
        quizAnswerID : Int,
        quizAnswerDesc : String,
        answerIsCorrect : Bool
    ){
        self.quizID = quizID
        self.quizDesc = quizDesc
        self.quizQuestionID = quizQuestionID
        self.quizQuestionDesc = quizQuestionDesc
        self.quizAnswerID = quizAnswerID
        self.quizAnswerDesc = quizAnswerDesc
        self.answerIsCorrect = answerIsCorrect
    }
}

class Quiz_TransactionData {
    //this class is matched with transaction data table used to store if users completed a quiz and their answers if yes
    var quizID : Int
    var userID : String
    var isCompleted : Bool
    var completedAt : Date
    var userRespID : Int
    
    init(
        quizID : Int,
        userID : String,
        isCompleted : Bool,
        completedAt : Date,
        userRespID : Int
    ){
        self.quizID = quizID
        self.userID = userID
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.userRespID = userRespID
    }
}
