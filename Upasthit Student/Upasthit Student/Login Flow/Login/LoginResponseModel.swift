//
//  LoginResponseModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let success: Bool
    let authToken: String?
    let message:String?
}
