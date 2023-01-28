//
//  EditProfileView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var profileVM:ProfileViewModel
    var body: some View {
        VStack{
            TextField("Name", text: $profileVM.studentName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Insitute Email", text: $profileVM.email)
                .textFieldStyle(.roundedBorder)
            
            TextField("Roll Number", text: $profileVM.rollNumber)
                .textFieldStyle(.roundedBorder)
            
            TextField("Batch", text: $profileVM.batch)
                .textFieldStyle(.roundedBorder)
            
            TextField("Branch", text: $profileVM.branch)
                .textFieldStyle(.roundedBorder)
            
            
            Button {
                //Save Credentials
            } label: {
                Text("Done")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }.padding()
            .navigationTitle("Edit Profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

