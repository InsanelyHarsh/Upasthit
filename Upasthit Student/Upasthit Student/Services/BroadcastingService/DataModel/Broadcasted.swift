//
//  Broadcasted.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
struct BroadcastedDataModel:Codable{
    let studentName:String
    let rollNumber:String
    let pin:String
    
    let confirmationResponse:Bool //If Revieved Attendance Response, then send confirmationResponse as True. To Tell Teacher, you got State of your Attendance either it is marked or not Marked + Reason!
}
