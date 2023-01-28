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
    @Persisted(primaryKey: true) var id:ObjectId
    
    @Persisted var courseName:String
    @Persisted var courseCode:String
    
    @Persisted var courseDescription:String
    @Persisted var courseCredit:String
    
    @Persisted var courseYear:String
    @Persisted var courseSemester:String
    
    @Persisted var serviceUUID:String
    
    @Persisted var department:String //Added New
    
//    @Persisted var instructors:List<TeacherModel> //Basic Detail
//    @Persisted var enrolledStudentData:List<EnrolledStudentDataModel> 
    @Persisted var courseAttendance:List<ClassAttendanceDBModel> //Only of Own
}
