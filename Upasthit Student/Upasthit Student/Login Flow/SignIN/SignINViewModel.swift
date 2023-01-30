//
//  SignINViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

class SignupViewModel:ObservableObject{
    @Published var name:String = "Harsh"
    @Published var email:String = "harsh@gmail.com"
    
    @Published var password:String = "Harsh@043"
    @Published var confirmPassword:String = "Harsh@043"
    
    @Published var department:Department = .ece
    @Published var batch:Double = 2020
    @Published var rollNumber:String = "20bec043"
    
    @Published var showAlert:Bool = false
    @Published var alert:CustomErrorAlertProtocol = LoginAlerts.userAlreadyExist
    
    @Published var isValidCredentials:Bool = false
    
    let authenticator = Authenticator.shared
    let networkingService = NetworkingService()
    let realmManager = RealmManager.shared
    
    @Published var isLoading:Bool = false
    
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
    
    func createAccount() async{
        if(self.validPass && self.validEmail){
            //TODO: Create Account
            
            await MainActor.run{
                self.isLoading = true
            }
            do{
                let responseMsg = try await self.networkingService.postJSON(url: URLData.createNewAccount.rawValue,
                                                                            requestData: SignupRequestModel(name: name, email: email, password: password, batch: Int(batch).description, branch: department.shortForm, rollno: rollNumber),
                                                                            responseType: SignupResponseModel.self)
                
                print(responseMsg)
                await MainActor.run{
//                    self.isLoading = false
                    
                    if let success = responseMsg.success{
                        if(success){
                            //Saving Token, Will be used many times in App.
                            UserDefaults.standard.set(responseMsg.authToken!, forKey: Constants.studentLoginToken)
                            self.isValidCredentials = true
                            
                            Task {
                                //TODO: Save Student Details
//                                await saveTeacherDetails(name: self.name, email: self.email, description: self.description)
                            }
                        }else{
                            self.alert = LoginAlerts.userAlreadyExist
                            self.showAlert = true
                        }
                    }
                    else{
                        if let error = responseMsg.errors{
                            let first = error[0]
                            
                            if(first.param == "password"){
                                self.alert = LoginAlerts.invalidPassword
                            }else if(first.param == "email"){
                                self.alert = LoginAlerts.invalidEmail
                            }else{
                                self.alert = LoginAlerts.invalidCredentials
                            }
                            self.showAlert = true
                        }
                    }
                }
            }catch(let err){
                await MainActor.run{
                    let x = err as! NetworkingError
                    self.alert = x
                    self.showAlert = true
                    self.isLoading = false
                }
                //TODO: Handle 400 requests
            }
        }else{
            //TODO: Show Alert (Invalid Email/Password)
            await MainActor.run{
                if(!self.validEmail){
                    self.alert = LoginAlerts.invalidEmail
                    self.showAlert = true
                }else{
                    self.alert = LoginAlerts.mismatchPass
                    self.showAlert = true
                }
            }
        }
    }
    
    private func saveTeacherDetails(name:String,email:String,description:String)async{
//        do{
//            try await MainActor.run {
//                let teacher = TeacherDBModel()
//                teacher.teacherName = name
//                teacher.email = email
//                teacher.teacherDescription = description
//
//                try self.realmManager.addNewItem(teacher)
//
//                self.isLoading = false
//            }
//        }catch(_){
//            print("Fuckkkk")
//            //TODO: Handle Errors.
//        }
    }
}

extension SignupViewModel{
    
}
