//
//  Scanned.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation


struct ScannedServiceDataModel:Decodable{
//    let validPIN:Bool //TODO: Remove this field
    let serviceID:String //TODO: replace with something else..
    let markedAttendance:Bool
}
