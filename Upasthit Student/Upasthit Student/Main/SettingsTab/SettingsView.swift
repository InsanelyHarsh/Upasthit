//
//  SettingsView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var sessionManager:SessionManager
    @State var showAlert:Bool = false
    let realmManager:RealmManager = RealmManager.shared
    var body: some View {
        VStack{
            Form {
                Section {
                    Text("Register New Course")
                    Text("Appearance")
                    Text("Notifications")
                }
                
                Section{
                    Text("About Us")
                    Text("Terms of Service")
                    Text("Privacy Policy")
                }
                
                Section{
                    Button {
                        self.showAlert.toggle()
                    } label: {
                        Text("Log Out")
                    }.tint(.red)
                }
            }
//            .navigationTitle("Settings")
//            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Log Out"),
                      message: Text("Do you want to Log out?"),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Yes"), action: {
                    withAnimation {
                        self.realmManager.deleteEveryThing()
                        self.sessionManager.didCurrentStateUpdated(to: .loggedOut)
                        
//                        self.sessionManager.signOut()
                        
//                        UserDefaults.standard.set(false, forKey: Constants.isBoardingCompletedKey)
//                        self.sessionManager.configureCurrentState()
                    }
                }))
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView()
        }
    }
}
