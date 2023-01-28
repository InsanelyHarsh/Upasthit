//
//  OnBoardingItem.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

struct OnBoardingItem:Identifiable,Equatable{
    let id = UUID()
    let emoji:String
    let title:String
    let content:String
}
