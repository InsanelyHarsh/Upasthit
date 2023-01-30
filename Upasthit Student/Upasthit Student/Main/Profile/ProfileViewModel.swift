//
//  ProfileViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
class ProfileViewModel:ObservableObject{
    let realmManager = RealmManager.shared
    
    @Published var student:StudentDBModel?
    
    ///Fetching Student Profile Data from Database
    func fetchCredentials(){
        self.student = self.realmManager.fetchData(StudentDBModel.self)[0]
    }
    
    //TODO: update changes
    func updateCredentails(){
    }
}
