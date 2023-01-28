//
//  RouteManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

enum HomeRoutingViews:Hashable{
    case courseDetail
}

enum AttendanceRoutingViews:Hashable{
    //TODO
}

enum SettingRoutingViews:Hashable{
    case aboutUS
    case registerNewCourse
}

///RouteManager Handles the Routing of Navigation after User is sucessfully Logged In.
class RouteManager:ObservableObject{
    
    @Published var route:NavigationPath = NavigationPath()
    @Published var showUserProfile:Bool = false
    
    ///Initial of Navigation
    func goToInitial(){
        self.route = NavigationPath()
    }
    
    func goBack(){
        if(self.route.count>0){
            self.route.removeLast()
        }else{
            Logger.logError("Already on Root View")
        }
    }
}
