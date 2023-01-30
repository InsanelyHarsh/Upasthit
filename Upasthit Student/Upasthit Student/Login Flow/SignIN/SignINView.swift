//
//  SignINView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import SwiftUI

struct SignINView: View {
    @ObservedObject var signinVM:SignupViewModel = SignupViewModel()
    @EnvironmentObject var loginFlowRouter:LoginFlowRouteManager
    @State var isSecured:Bool = true
    @State var isConfirmSecured:Bool = true
    @State var val:Double = 2020
    let action:()->Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(spacing: 40){
            
            VStack(spacing: 15){
                VStack{
                    TextField("Name", text: $signinVM.name)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Email", text: $signinVM.email)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                VStack{
                    TextField("Roll Number", text: $signinVM.name)
                        .textFieldStyle(.roundedBorder)
                    
                    Slider(value: $val, in: (2019...2025), step: 1) {
                        Text("Label")
                    } minimumValueLabel: {
                        Text("Batch")
                    } maximumValueLabel: {
                        Text("\(Int(val).description)")
                    } onEditingChanged: { _ in
                        
                    }
                }

                VStack(spacing: 10){
                    PasswordFieldView(isSecured: $isSecured, password: $signinVM.password, title: "Password")
                    
                    PasswordFieldView(isSecured: $isConfirmSecured, password: $signinVM.confirmPassword, title: "Confirm")
                        
                }.textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                VStack{
                    //TODO: Department Field
                    LabeledContent("Department") {
                        Picker("Dep", selection: $signinVM.department) {
                            ForEach(Department.allCases,id:\.self){ d in
                                Text("\(d.shortForm)")
                            }
                        }.tint(.purple)
                    }
                }
            }

            
            Button {
                    self.action()
                //TODO: ....
//                self.signupVM.createAccount()
            } label: {
                Text("Create New Account")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .bold()
            
            
            Spacer()
        }.padding()
        .navigationTitle("Greatness is Comming")
        .alert(self.signinVM.alert.alertTitle, isPresented: $signinVM.showAlert) {
            //Action..
        } message: {
            Text(self.signinVM.alert.alertDescription)
        }

    }
}

struct SignINView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignINView{ }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(LoginFlowRouteManager())
        }
    }
}
