//
//  TeacherDBModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
import RealmSwift

class TeacherDBModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:ObjectId
    
    @Persisted var teacherName:String
    @Persisted var email:String
    
    ///Courses that teaching currently
    @Persisted(originProperty: "instructors") var courses:LinkingObjects<CourseDBModel>
    
    ///Description of Teacher and qualifications, optional
    @Persisted var teacherDescription: String
}
