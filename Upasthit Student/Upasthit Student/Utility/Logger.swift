//
//  Logger.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

///Logs Msg or Error to Terminal
struct Logger{
    
    static func logMessage(_ completion:@autoclosure (()->(String)) ){
        print("[LOG] \(completion()) \n")
    }
    
    static func logError(_ completion:@autoclosure (()->(String)) ){
        print("\n [ERROR] \(completion()) \n")
    }
    
    static func logLine(){
        print("\n------------------------------------\n")
    }
}
