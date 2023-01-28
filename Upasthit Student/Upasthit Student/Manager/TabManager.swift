//
//  TabManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

///TabRoutingViews Handles Tab of View(after Logged In) 
enum TabRoutingViews:String, Hashable{
    case home = "Home"
    case attendance = "Attendance"
    case settings = "Settings"
}

///Handles Tab of Application
class TabManager:ObservableObject{
    @Published var currentTab:TabRoutingViews = .home
    
    func changeTab(to newTab:TabRoutingViews){
        self.currentTab = newTab
    }
}
