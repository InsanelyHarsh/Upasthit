//
//  MarkAttendanceView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

enum MarkAttendanceRoute{
    case attendanceDetail
}

struct MarkAttendanceView: View {
    @EnvironmentObject var routeManger:RouteManager
    var body: some View {
        VStack{
            Rectangle()
                .cornerRadius(8)
                .frame(height: UIScreen.main.bounds.height*0.45)
                .padding()
                .foregroundColor(.gray)
                .overlay {
                    Button(action: {
                        
                    }, label: {
                        Text("Turn on Camera")
                    })
                    .font(.title3)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            
            List{
                LabeledContent("Bluetooth"){
                    Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                }
                
                LabeledContent("Location"){
                    Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                }
                
                LabeledContent("Camera"){
                    Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                }
            }.listStyle(.plain)
            
            
            Spacer()
            
            NavigationLink(value: MarkAttendanceRoute.attendanceDetail) {
                Text("Start Attentance")
            }
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            .font(.title2)
            .padding(.bottom,20)

            
        }
        .navigationTitle("Mark Attendance")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
        .navigationDestination(for: MarkAttendanceRoute.self) { value in
            if(value == .attendanceDetail){
                AttendanceDetailView{
                    self.routeManger.goBack()
                }
            }
        }
    }
}

struct MarkAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MarkAttendanceView()
        }
//        MainView()
    }
}
