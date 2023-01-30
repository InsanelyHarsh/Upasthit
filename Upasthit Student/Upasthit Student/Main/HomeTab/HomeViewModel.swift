//
//  HomeViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
//import RealmSwift
//
//struct RegisteredCourseList:Identifiable{
//    let courseName:String
//    let id:ObjectId
//}
class HomeViewModel:ObservableObject{
    private let realmManager:RealmManager = RealmManager.shared
    @Published private(set) var registeredCourseList:[CourseDBModel] = []
    
    init(){
//        getCourseList()
    }
    func getCourseList(){
        self.registeredCourseList = realmManager.fetchData(CourseDBModel.self).map{ $0 }
    }
    
//    func getDummyCourseList(){
//        let course1 = CourseDBModel()
//        course1.courseName = "SDN"
////        course1.instructors ="Verma Sir"
//        course1.courseSemester = "5"
//        course1.courseYear = "2020"
//        course1.courseCode = "DEV101"
//        course1.department = "ECE"
//        course1.courseDescription = "This is Really Great!"
//        realmManager.add(course1)
//
//        self.getCourseList()
//    }
}
