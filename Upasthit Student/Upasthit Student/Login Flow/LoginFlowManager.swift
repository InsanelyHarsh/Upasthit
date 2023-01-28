//
//  LoginFlowManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

///Login Flow State are States/Views of Login-Flow
enum LoginFlowState:Hashable{
    case login
    case createNewAccount
    case forgotPassword
}

///LoginFlowRouteManager handles routing of Views(Login,Create new Account & Forgot Password)
///Navigation between Login Flow Views
final class LoginFlowRouteManager:ObservableObject{
    
    @Published var loginFlowRoutingPath:[LoginFlowState] = []
    
    func goBack(){
        if(self.loginFlowRoutingPath.count>0){
            self.loginFlowRoutingPath.removeLast()
        }
    }
    
    func goToMainLoginView(){
        self.loginFlowRoutingPath = []
    }
    
    func navigationTo(_ state:LoginFlowState){
        self.loginFlowRoutingPath.append(state)
    }
}
