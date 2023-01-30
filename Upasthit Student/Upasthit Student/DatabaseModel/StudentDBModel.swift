//
//  StudentDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import RealmSwift

//MARK: Access StudentModel by Email
class StudentDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId //Primary Key

    @Persisted var studentName:String
    @Persisted var email:String
    @Persisted var rollNumber:String

    ///Inverse Relationship with Course
    ///- Each Course have many Student
    ///- Each Student have many Courses
//    @Persisted(originProperty: "enrolledStudentData") var courses:LinkingObjects<CourseDBModel>

    @Persisted var batch:String
    @Persisted var branch:String
}
