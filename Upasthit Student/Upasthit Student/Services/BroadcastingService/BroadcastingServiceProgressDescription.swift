//
//  BroadcastingServiceProgressDescription.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation


enum BroadcastingServiceProgressDescription:String{
    case broadcastingStarted = "Broadcasting has been Started 🚀"
    case broadcastingStopped = "Broadcasting has been Stopped."
    
    case connectionMadeWithTeacherDevice = "Connection has been Made 🤝"
    case didconnectedToTeacherDevice = "Disconnected with Teacher Device."
    
    case checkingCredentails = "Checking Credentials & Marking Attendance."
    
    case readingTeacherResponse = "Checking Response From Teacher.🔬"
    case bleStateUpdated = "Bluetooth State has been Updated"
}




enum BroadcastingServiceErrorDescription:String, Error{
    case bluetoothIsTurnedOff = "Turn on Bluetooth."
    case broadcastingError = "Error Occured while Broadcasting, Please try Again. ⚠️"
}
