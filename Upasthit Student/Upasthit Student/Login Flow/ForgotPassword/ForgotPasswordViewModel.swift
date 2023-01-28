//
//  ForgotPasswordViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

class ForgotPasswordViewModel:ObservableObject{
    @Published var registeredEmail:String = ""
    
    @Published var newPassword:String = ""
    @Published var newConfirmPassword:String = ""
    
    @Published var isNewPasswordCorrect:Bool = false
    
    
    //TODO: Maybe Use Authenticator?
    func checkPassword(){
        if(newPassword == newConfirmPassword){
            self.isNewPasswordCorrect = true
        }else{
            self.isNewPasswordCorrect = false
        }
    }
}
