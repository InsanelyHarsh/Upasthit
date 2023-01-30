//
//  ProfileView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

enum ProfileRoute{
    case edit
}
struct ProfileView: View {
    @StateObject var profileVM:ProfileViewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                if(profileVM.student == nil){
                    ProgressView("Fetching Profile Details")
                }else{                
                    Form{
                        Section {
                            LabeledContent("Name", value: profileVM.student!.studentName)
                            LabeledContent("Roll Number", value: profileVM.student!.rollNumber)
                            LabeledContent("Institute Email", value: profileVM.student!.email)
                        } header: {
                            Text("Credentials")
                        }
                        Section{
                            LabeledContent("Batch", value: profileVM.student!.batch)
                            LabeledContent("Branch", value: profileVM.student!.branch)
                        }
                    }
                }
            }
            .onAppear{
                self.profileVM.fetchCredentials()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.dismiss.callAsFunction()
                    } label: {
                        Text("Close")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("EDIT", value: ProfileRoute.edit)
                }
            }
            .navigationDestination(for: ProfileRoute.self) { value in
                if(value == .edit){
                    EditProfileView()
                        .environmentObject(profileVM)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack{
            ProfileView()
//        }.navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.inline)
    }
}
