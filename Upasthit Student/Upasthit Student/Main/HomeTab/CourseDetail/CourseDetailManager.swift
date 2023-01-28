//
//  CourseDetailManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

class CourseDetailManager:ObservableObject{
    @Published private(set) var registeredCourses:[CourseDetailModel] = []
    
    
    func addNewCourse(_ course:CourseDetailModel){
        
    }
    
    ///Dummy Data
    func getCourseList(){
        //Dummy Data for now, actual Networking Call or fetch from DB
        
        self.registeredCourses = [.init(courseInstructor: "Dr. Abhishek Verma", courseName: "Software Defined Networking", courseCode: "OE304", sem: "5", year: "2022"),
                                  .init(courseInstructor: "Pushpa Ma'am", courseName: "VLSI", courseCode: "EC3009", sem: "5", year: "2022"),
                                  .init(courseInstructor: "Dinesh Kumar Verma", courseName: "Electromagnetic Theory", courseCode: "EC3010", sem: "5", year: "2022"),
                                  .init(courseInstructor: "Dr. K. Dutt", courseName: "IT Workshop", courseCode: "IT3001", sem: "5", year: "2022"),
                                  .init(courseInstructor: "Atul Kumar", courseName: "Digital Communication", courseCode: "EC3011", sem: "5", year: "2022"),
        ]
    }
    
    
    func getCourseData(){
        //TODO: Get Course Data from DB
    }
    
    //TODO: Implement Graph and other stats
}
