//
//  SignINViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

class SignINViewModel:ObservableObject{
    @Published var name:String = ""
    @Published var email:String = ""
    
    @Published var password:String = ""
    @Published var confirmPassword:String = ""
    
    @Published var department:Department = .ece
    
    @Published var showAlert:Bool = false
    @Published var alert:LoginAlerts = .userAlreadyExist
    
    let authenticator = Authenticator.shared
    
    var validPass:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.password, confirmPassword: self.confirmPassword)
        }
    }
    
    var validEmail:Bool{
        get{
            return self.authenticator.isValidEmail(self.email)
        }
    }
    
    func createAccount(){
        if(self.validPass && self.validEmail){
            //TODO: Create Account
        }else{
            //TODO: Show Alert (Invalid Email/Password)
            if(!self.validEmail){
                self.alert = .invalidEmail
                self.showAlert = true
            }else{
                self.alert = .mismatchPass
                self.showAlert = true
            }
        }
    }
}

extension SignINViewModel{
    
}
