//
//  RootView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct RootView: View {
    @StateObject private var sessionManager:SessionManager = SessionManager()
    var body: some View {
        ZStack{
            switch sessionManager.currentState{
            case .loggedIn:
                MainView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
            case .loggedOut:
                MainLoginView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
            case .onBoarding:
                OnBoardingView{
//                    self.sessionManager.signOut()
                    self.sessionManager.didCurrentStateUpdated(to: .loggedOut)
                }
                .transition(.opacity)
                .environmentObject(sessionManager)
            case .dataRetrieval:
                Text("Data Retrieval") //TODO: Implement Data Retrieval
            }
        }.onAppear{
            self.sessionManager.configureCurrentState()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
