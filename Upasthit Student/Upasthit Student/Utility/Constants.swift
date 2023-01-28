//
//  Constants.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import CoreBluetooth

struct Constants{
    ///Enum holding Current Session --> Login/ Logged Out/ OnBoarding/ Data Retrieval
    static var userSessionKey:String = "CURRENT_USER_SESSION_KEY---[USER_DEFAULT_KEY]"
    
    /// Session Token of Student, Get Token While Logging
    static var studentLoginToken:String = "STUDENT_LOGIN_TOKEN"
    
    //Send by Student & scanned by Teacher..
    static var SERVICE_UUID:CBUUID = CBUUID(string: "759aabaf-1ffa-4e7b-b511-1dd267e066b3")
    static var CHAR_UUID = CBUUID(string: "e6e0f9c1-b753-4266-88d5-8423c571de17")
}








enum URLData:String{
    case login = "https://upasthit-backend.vercel.app/api/student/login"
//    case forgotPassword = "https://upasthit-backend.vercel.app/api/teacher/forgotpassword"
    
    case createNewAccount = "https://upasthit-backend.vercel.app/api/student/createStudent"
    case editStudent = "https://upasthit-backend.vercel.app/api/student/editStudent"
    
    //GET course,attendance..
}
