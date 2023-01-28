//
//  ProfileViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
class ProfileViewModel:ObservableObject{
//    var realm = RealmManager.shared.realm
    
    //studentName
    @Published var studentName:String = "Harsh Mohan Yadav"
    @Published var email:String = "20bec043@iiitdmj.ac.in"
    @Published var rollNumber:String = "20BEC043"
    @Published var batch:String = "2020"
    @Published var branch:String = Branch.ece.branchName
    
    
    ///Fetch Student Profile Data from Database
    func fetchCredentials(){
        //fetch
    }
    
    func updateCredentails(){
        //update changes
    }
}
