//
//  ClassAttendanceDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import RealmSwift


class ClassAttendanceDBModel:Object,ObjectKeyIdentifiable{
    @Persisted var date:Date

    @Persisted var attendanceRecord:List<StudentRecordDBModel>
}




class StudentRecordDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:ObjectId

    @Persisted var isPresent:Bool = false
    @Persisted var email:String
    @Persisted var logStatus:String

    @Persisted var timeOfAttendane:Date
}
