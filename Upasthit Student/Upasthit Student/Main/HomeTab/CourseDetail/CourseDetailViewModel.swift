//
//  CourseDetailViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
import RealmSwift
class CourseDetailViewModel:ObservableObject{
    
    @Published var courseDetail:CourseDBModel?
    @Published var attendanceRecord:[ClassAttendanceDBModel] = []
    private let realmManager:RealmManager = RealmManager.shared
    
    func getCourseDetail(of course:String){
//        self.realmManager.fetchData(<#T##type: T.Type##T.Type#>)
    }
    
    func getAttendance(of courseID:ObjectId){
        guard let dbRef = realmManager.realm else{ return }
//        let course = dbRef.objects(CourseDBModel.self).where {
//            $0._id == courseID
//        }
        let courseAttendance = dbRef.object(ofType: CourseDBModel.self, forPrimaryKey: courseID)!.freeze().courseAttendance
        self.attendanceRecord = courseAttendance.map{$0}
    }
}
