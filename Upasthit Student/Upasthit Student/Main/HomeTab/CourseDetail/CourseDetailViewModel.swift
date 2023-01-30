//
//  CourseDetailViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
class CourseDetailViewModel:ObservableObject{
    
    @Published var courseDetail:CourseDBModel?
    
    private let realmManager:RealmManager = RealmManager.shared
    
    func getCourseDetail(of course:String){
//        self.realmManager.fetchData(<#T##type: T.Type##T.Type#>)
    }
}
