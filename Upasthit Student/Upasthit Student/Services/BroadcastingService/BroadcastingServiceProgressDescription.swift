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


enum BroadcastingServiceErrorDescription:Error,CustomErrorAlertProtocol{
    case bluetoothIsTurnedOff
    case readingResponseFailed
    case broadcastingError
    case encodingFailed
    case decodingFailed
    
    
    var alertTitle: String{
        switch self {
        case .bluetoothIsTurnedOff:
            return "Turn on Bluetooth"
        case .readingResponseFailed:
            return "Error"
        case .broadcastingError:
            return "Error"
        case .encodingFailed:
            return "Error"
        case .decodingFailed:
            return "Error"
        }
    }
    
    var alertDescription: String{
        switch self {
        case .bluetoothIsTurnedOff:
            return "Grant Permission & Turn on Bluetooth \n To Mark Attendance"
        case .broadcastingError:
            return "Error Occured while Broadcasting, Please try Again. ⚠️ \n Contact Developer."
        case .readingResponseFailed:
            return "Unable to Read Response. \n Please Try Again."
        case .encodingFailed:
            return "Encoding Failed, Please Try Again"
        case .decodingFailed:
            return "Decoding Failed, Please Try Again"
        }
    }
}
