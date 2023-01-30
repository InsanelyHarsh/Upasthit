//
//  CourseDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import RealmSwift

//TODO: department
class CourseDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId
    
    @Persisted var courseName:String
    @Persisted var courseCode:String
    
    @Persisted var courseDescription:String
    @Persisted var courseCredit:String
    
    @Persisted var courseYear:String
    @Persisted var courseSemester:String
    
    @Persisted var serviceUUID:String
    
    @Persisted var department:String //Added New
    
    @Persisted var instructors:List<TeacherDBModel> //Basic Detail
    @Persisted var enrolledStudentData:List<EnrolledStudentDBModel> //
    @Persisted var courseAttendance:List<ClassAttendanceDBModel> //Only of Own
}
