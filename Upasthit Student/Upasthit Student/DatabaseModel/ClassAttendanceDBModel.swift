//
//  ClassAttendanceDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import RealmSwift


class ClassAttendanceDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId
    @Persisted var date:Date

    @Persisted var attendanceRecord:List<StudentRecordDBModel>
}




//Record of Each Student
class StudentRecordDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId

    @Persisted var isPresent:Bool = false
    @Persisted var email:String
    @Persisted var logStatus:String

    @Persisted var timeOfAttendane:Date //Time of Attendance of Each Student
}
