//
//  OnBoardingManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

///OnBoardingManager handles the OnBoardingViews Content
final class OnBoardingManager:ObservableObject{
    ///Array of OnBoarding Item shown on OnBoarding Views
    @Published private(set) var items:[OnBoardingItem] = []
    
    
    ///Function populate items with default Data
    func load(){
        self.items = [.init(emoji: "🚀", title: "Offline Attendance", content: "Revolutionary & Robust Attendance System."),
                      .init(emoji: "📈", title: "Track Attendance", content: "Simple way to Manage Attendance. No More Tedious Record Entries."),
                      .init(emoji: "⏳", title: "Save Time", content: "Be More Productive! No More Worry of Missing Attendance")
        ]
    }
}
