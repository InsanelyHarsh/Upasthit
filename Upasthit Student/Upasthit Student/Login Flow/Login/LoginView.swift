//
//  LoginView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginVM:LoginViewModel = LoginViewModel()
    @EnvironmentObject var loginFlowRouter:LoginFlowRouteManager
    
    @State var isSecured:Bool = true
    let action:(_ retrieveData:Bool)->Void
    
    var body: some View {
        ZStack{
//            if(self.loginVM.isLoading){
//                ProgressView()
//            }
            VStack(spacing: 40){
                
                VStack(spacing: 10){
                    TextField("Enter your Email", text: $loginVM.email)
                        .textFieldStyle(.roundedBorder)
                    
                    PasswordFieldView(isSecured: $isSecured, password: $loginVM.password, title: "Enter Password")
                }
                HStack{
                    Spacer()

                    Button {
                        self.loginFlowRouter.navigationTo(.forgotPassword)
                    } label: {
                        Text("Forgot Password?")
                            .underline()
                            .font(.subheadline)
                    }.padding(.trailing,5)
                }
                .padding(.top,-20)
                
                Button {
                    Task{
                        await self.loginVM.login()
                    }
                } label: {
                    HStack(spacing: 5){
                        Text("Login")
                        if(self.loginVM.isLoading){
                            ProgressView()
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .bold()
                .disabled(self.loginVM.isLoading)
                
                Spacer()
            }.padding()
        }
        .navigationTitle("Login")
        .alert(self.loginVM.alert.alertTitle, isPresented: $loginVM.showAlert) {
            //Action..
        } message: {
           Text(self.loginVM.alert.alertTitle)
        }
        .alert(isPresented: $loginVM.retrieveData) {
            Alert(title: Text("Retrieve Data"), message: Text("I might take some time to setup.\n Start only if you Time."), primaryButton: .default(Text("Start Retrieval"), action: {
//                self.loginVM.isValidCredentials = true
                self.action(true)
            }), secondaryButton: .destructive(Text("Skip"), action: {
                self.action(false)
//                self.loginVM.isValidCredentials = false
            }))
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginView{ retrieveData in }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(LoginFlowRouteManager())
        }
    }
}
