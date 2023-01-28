//
//  Department.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
enum Department:CaseIterable{
    case ece
    case cse
    case me
    case sm
    case design
//    case open
    
    
    var fullName:String{
        switch self {
        case .ece:
            return "Electronics & Communication"
        case .cse:
            return "Computer Science"
        case .me:
            return "Mechanical"
        case .sm:
            return "Smart Manufacturing"
        case .design:
            return "Design"
//        case .open:
//            return "All"
        }
    }
    
    var shortForm:String{
        switch self {
        case .ece:
            return "ECE"
        case .cse:
            return "CSE"
        case .me:
            return "ME"
        case .sm:
            return "SM"
        case .design:
            return "B.Des"
//        case .open:
//            return "Open"
        }
    }
}
