//
//  AttendanceDetailAlertError.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
struct AttendanceAlert{
    static let none:String = "none"

    static let broadcastingError:String = ""
    static let stopBroadcasting:String = ""
    static let wrongPIN:String = ""
    static let bluetoothOff:String = ""
}
enum AttendanceDetailAlertError:CustomErrorAlertProtocol{
    case none
    case broadcastingError //
    case stopBroadcasting //
    case wrongPIN
    case bluetoothOff //
    
    var alertTitle:String{
        switch self {
        case .none:
            return "None"
        case .broadcastingError:
            return "Broadcasting Error"
        case .stopBroadcasting:
            return "Broadcasting Stopped"
        case .wrongPIN:
            return "Wrong PIN"
        case .bluetoothOff:
            return "Bluetooth Off"
        }
    }
    
    var alertDescription:String{
        switch self {
        case .none:
            return "Error Occured While Broadcasting. \n Contact Developer"
        case .broadcastingError:
            return "Please Try Again"
        case .stopBroadcasting:
            return "Marking Attendance Process is Stopped"
        case .wrongPIN:
            return "Enter Valid PIN"
        case .bluetoothOff:
            return "Grand Permission & Turn On Bluetooth"
        }
    }
}
