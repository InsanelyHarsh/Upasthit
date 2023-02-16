//
//  BroadcastingServiceStateDescription.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 16/02/23.
//

import Foundation

enum BroadcastingServiceStateDescription:Int{
    case poweredOff = 4
    case poweredOn = 5
    case resetting = 1
    case unauthorized = 3
    case unknown = 0
    case unsupported = 2
    
    var stateDescription:String{
        switch self {
        case .poweredOff:
            return "Bluetooth is currently powered off."
        case .poweredOn:
            return "Bluetooth is currently powered on and available to use."
        case .resetting:
            return "Connnection with the system service was momentarily lost."
        case .unauthorized:
            return "Application isn’t authorized to use the Bluetooth low energy role."
        case .unknown:
            return "The manager’s state is unknown."
        case .unsupported:
            return "Device doesn’t support the Bluetooth low energy central or client role."
        }
    }
}
