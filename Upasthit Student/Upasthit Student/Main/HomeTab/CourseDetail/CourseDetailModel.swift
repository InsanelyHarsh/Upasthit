//
//  CourseDetailModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

struct CourseDetailModel:Identifiable,Hashable{
    let id = UUID()
    
    let courseInstructor:String
    
    let courseName:String
    let courseCode:String
    
    let sem:String
    let year:String
}
