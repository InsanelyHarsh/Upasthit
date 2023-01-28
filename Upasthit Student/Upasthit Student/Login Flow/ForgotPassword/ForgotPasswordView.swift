//
//  ForgotPasswordView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var forgotPasswordVM:ForgotPasswordViewModel = ForgotPasswordViewModel()
    let action:()->Void
    
    @State var isSecured:Bool = true
    @State var isConfirmSecured:Bool = true
    
    var body: some View {
        VStack(spacing: 40){
            VStack(spacing: 10){
                TextField("Enter your Email", text: $forgotPasswordVM.registeredEmail)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom,10)
                
                
                PasswordFieldView(isSecured: $isSecured, password: $forgotPasswordVM.newPassword, title: "New Password")
                
                PasswordFieldView(isSecured: $isConfirmSecured, password: $forgotPasswordVM.newConfirmPassword, title: "Confirm New Password")

            }.padding()
            
            Button {
                action()
            } label: {
                Text("Update Password")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)

            Spacer()
        }.navigationTitle("Forgot Password")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ForgotPasswordView{ }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
