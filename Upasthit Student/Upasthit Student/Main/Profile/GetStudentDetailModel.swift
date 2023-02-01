//
//  GetStudentDetailModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 30/01/23.
//

import Foundation
/*
 {
     "success": true,
     "teacher": null
 }
 
 
 {
     "success": true,
     "teacher": {
         "_id": "63b95c9f4e4350c5e33f0405",
         "name": "janmesh Kumar",
         "userType": "teacher",
         "email": "janmesh799@gmail.com",
         "description": "Awesome Teacher",
         "courses": [],
         "__v": 0
     }
 }
 */


/*
 {
     "success": true,
     "teacher": {
         "_id": "63bbf1d59acf167ed247b2ab",
         "name": "Jatin",
         "userType": "teacher",
         "email": "jatin@gmail.com",
         "description": "",
         "courses": [
             "63bbf2509acf167ed247b2b3"
         ],
         "__v": 1
     }
 }
 */
// MARK: - GetStudentDetailModel
struct GetStudentDetailModel: Decodable {
    let success: Bool
    let teacher: Student?
}

// MARK: - Teacher
struct Student: Decodable {
    let _id, name, userType, email: String
    let description: String
}
