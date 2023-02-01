//
//  AttendanceDetailView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct AttendanceDetailView: View {
    let attendanceMarkedAction:(()->Void)
    @StateObject var attendanceDetailVM:AttendanceDetailViewModel = AttendanceDetailViewModel()
    var body: some View {
        VStack{
            List{
                LabeledContent("State") {
                    Text("\(self.attendanceDetailVM.bluetoothState)")
                }
                LabeledContent("Progress") {
                    Text("\(self.attendanceDetailVM.progressDescription)")
                }
                
            }.listStyle(.plain)
                .frame(height: 120)
            
            
            TextField("Enter Teacher Generated PIN", text: $attendanceDetailVM.attendancePIN)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            
            Spacer()
        
            HStack{
                Button {
                    self.attendanceDetailVM.attendanceProcessCompleted = false
                    self.attendanceDetailVM.attendanceMarkedSucessfully = false
                    self.attendanceDetailVM.startBroadcasting()
                } label: {
                    Text("Start Attendance")
                }.buttonStyle(.borderedProminent)
                    .disabled(self.attendanceDetailVM.isBroadcasting)
                
                Button {
                    self.attendanceDetailVM.stopBroadcasting()
                } label: {
                    Text("Stop Attendance")
                }.buttonStyle(.bordered)
                    .disabled(!self.attendanceDetailVM.isBroadcasting)
            }
            .font(.title3)
            .padding(.bottom,20)
        }
        .navigationTitle("Mark Attendance")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert(self.attendanceDetailVM.alertType.alertTitle, isPresented: $attendanceDetailVM.showAlert, actions: {
            
        }, message: {
            Text(self.attendanceDetailVM.alertType.alertDescription)
        })

        .onChange(of: self.attendanceDetailVM.attendanceMarkedSucessfully) { newValue in
            if(newValue && self.attendanceDetailVM.attendanceProcessCompleted){
                self.attendanceMarkedAction()
            }
        }
    }
}

struct AttendanceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AttendanceDetailView{
                
            }
        }
    }
}
