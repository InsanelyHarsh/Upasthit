//
//  LoginViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation

class LoginViewModel:ObservableObject{
    @Published var email:String = "harsh@gmail.com"
    @Published var password:String = "Harsh@043"
    
    @Published var isValidCredentials:Bool = false
    @Published var retrieveData:Bool = false
    
    @Published var showAlert:Bool = false
    @Published var alert:CustomErrorAlertProtocol = LoginAlerts.invalidEmail
    
    let authenticator = Authenticator.shared
    let networkingService = NetworkingService()
    let realmManager = RealmManager.shared
    
    @Published var isLoading:Bool = false
    var validPass:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.password)
        }
    }
    
    var validEmail:Bool{
        get{
            return self.authenticator.isValidEmail(self.email)
        }
    }
    
//    private func getTeacherDetails(token:String) async{
//        do{
//            let temp = "https://upasthit-backend.vercel.app/api/teacher/findTeacher/\(email)"
//            let response = try await self.networkingService.getJSON(url: "\(temp)", type: GetTeacherDetailsModel.self,authToken: token)
//            if(response.success){
//                print(response)
//                Logger.logLine()
//                //TODO: Save Teacher Details and show on profile
//                if(response.teacher != nil){
//                    await self.saveTeacherDetails(data: response)
//                }else{
//                    self.alert = LoginAlerts.unknownError
//                    self.showAlert = true
//                    self.isLoading = false
//                }
//            }
//        }catch(let err){
//            //TODO: Handle Errors
//            await MainActor.run{
//                let x = err as! NetworkingError
//                self.alert = x
//                self.showAlert = true
//                self.isLoading = false
//            }
//        }
//    }
    
    private func saveStudentDetail(data:GetStudentDetailModel)async{
        //
    }
    
    func login() async{
        if(self.validEmail && self.validPass){
            await MainActor.run{
                self.isLoading = true
            }
            do{
                let responseMsg = try await self.networkingService.postJSON(url: URLData.login.rawValue,
                                                                            requestData: LoginRequestModel(email: email, password: password), responseType: LoginResponseModel.self)
                
                await MainActor.run{
//                    self.isLoading = false
                    
                    if(responseMsg.success){
                        //MARK: Get Teacher Details
                        //MARK: Save profile Details
                        Task{
//                            await getTeacherDetails(token: responseMsg.authToken!)
                        }
                        //MARK: Store Token
                        UserDefaults.standard.set(responseMsg.authToken!, forKey: Constants.studentLoginToken) //Saving Token, Will be used many times in App.
                        self.retrieveData = true //show alert, asking to retrieve Data
                        
                    }else{
                        self.alert = LoginAlerts.invalidCredentials
                        self.showAlert = true
                    }
                }
            }catch(let error){
                let networkingError = error as! NetworkingError
                await MainActor.run(body: {
                    self.alert = networkingError

                    self.showAlert = true
                    self.isLoading = false
                })
            }
        }else{
            await MainActor.run{
                if(!self.validEmail){
                    self.alert = LoginAlerts.invalidEmail
                    self.showAlert = true
                }else{
                    self.alert = LoginAlerts.invalidPassword
                    self.showAlert = true
                }
            }
        }
    }
}
