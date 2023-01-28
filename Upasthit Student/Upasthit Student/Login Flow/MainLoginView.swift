//
//  MainLoginView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct MainLoginView: View {
    
    @StateObject var loginFlowRouter:LoginFlowRouteManager = LoginFlowRouteManager()
    @EnvironmentObject var sessionManager:SessionManager
    
    var body: some View {
        NavigationStack(path: $loginFlowRouter.loginFlowRoutingPath) {
            VStack(spacing: 90){
                
                Text("New & Robust Attendance System")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                VStack{
                    
                    Button {
                        self.loginFlowRouter.navigationTo(.login)
                    } label: {
                        Text("Continue your Great Journey")
                    }.buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .bold()
                    
                    CustomDivider()
                    
                    Button {
                        self.loginFlowRouter.navigationTo(.createNewAccount)
                    } label: {
                        Text("Start New Journey 🎉")
                    }.buttonStyle(.borderedProminent)
                        .tint(.cyan)
                        .bold()
                }

                
                Spacer()
            }
            .environmentObject(loginFlowRouter)
            .navigationDestination(for: LoginFlowState.self, destination: { state in
                switch state{
                case .login:
                    LoginView{ retrieveData in                                      //TODO: Improve this functionality
                        if(retrieveData){
                            self.loginFlowRouter.goToMainLoginView()
                            self.sessionManager.didCurrentStateUpdated(to: .dataRetrieval)
//                            self.sessionManager.showRetrieval()
                        }else{
                            self.loginFlowRouter.goToMainLoginView()
//                            self.sessionManager.loginCompleted()
                            self.sessionManager.didCurrentStateUpdated(to: .loggedIn)
                        }
                    }.environmentObject(loginFlowRouter)
//                        .environmentObject(sessionManager)
                case .forgotPassword:
                    ForgotPasswordView{
                        withAnimation {
                            self.loginFlowRouter.goBack()
                        }
                    }
                case .createNewAccount:
                    SignINView{
                        self.loginFlowRouter.goToMainLoginView()
//                        self.sessionManager.loginCompleted()
                        self.sessionManager.didCurrentStateUpdated(to: .loggedIn)
                    }
                }
            })
            .navigationTitle("🚀")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}

