//
//  SignInRequestModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
// MARK: - SignupRequestModel
struct SignupRequestModel: Codable {
    let name, email, password, batch,branch,rollno: String
}


/*
 {
     "name":"Janmesh",
     "email":"Janmesh799@gmail.com",
     "password":"Hello@world799",
     "batch":"2020",
     "branch":"ECE",
     "rollno":"20BEC047"
 }
 */
