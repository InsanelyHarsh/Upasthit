//
//  SessionManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import SwiftUI

///Session Manager controls the Weather user is Logged in/out along with OnBoarding View
///Session Manager controls the Weather user is Logged in/out along with OnBoarding View
final class SessionManager:ObservableObject{
    
    enum CurrentState:Int{
        case onBoarding
        case loggedIn
        case dataRetrieval
        case loggedOut
    }
    
    @Published private(set) var currentState:CurrentState = .onBoarding
    
//    func signOut(){
//        withAnimation {
//            UserDefaults.standard.set(CurrentState.loggedOut.rawValue, forKey: Constants.userSessionKey)
//            self.currentState = .loggedOut
//        }
//    }
//    
//    func onBoardingCompleted(){
//        withAnimation {
//            UserDefaults.standard.set(CurrentState.loggedOut.rawValue, forKey: Constants.userSessionKey)
//            self.currentState = .loggedOut
//        }
//    }
//    
//    func loginCompleted(){
//        withAnimation {
//            UserDefaults.standard.set(CurrentState.loggedIn.rawValue, forKey: Constants.userSessionKey)
//            self.currentState = .loggedIn
//        }
//    }
//    
//    func showRetrieval(){
//        withAnimation {
//            UserDefaults.standard.set(CurrentState.dataRetrieval.rawValue, forKey: Constants.userSessionKey)
//            self.currentState = .dataRetrieval
//        }
//    }
    
    func configureCurrentState(){
//        UserDefaults.standard.removeObject(forKey: Constants.userSessionKey)
        
        let prevStoredState = UserDefaults.standard.object(forKey: Constants.userSessionKey)
        if(prevStoredState != nil){
            self.currentState =  SessionManager.CurrentState(rawValue: prevStoredState as! Int)!
        }
        
//        let hasSeenOnBording = UserDefaults.standard.bool(forKey: Constants.isBoardingCompletedKey)
//        currentState  = hasSeenOnBording ? .loggedOut : .onBoarding
    }
    
    func didCurrentStateUpdated(to newState:CurrentState){
        withAnimation {
            UserDefaults.standard.set(newState.rawValue, forKey: Constants.userSessionKey)
            self.currentState = newState
        }
    }
}
