//
//  EnrolledStudentDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
import RealmSwift

class EnrolledStudentDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:ObjectId
    
    @Persisted var email:String
    @Persisted var invitationStatus:Bool
    
    @Persisted var characteristicUUID:String
    @Persisted var serviceUUID:String
}
