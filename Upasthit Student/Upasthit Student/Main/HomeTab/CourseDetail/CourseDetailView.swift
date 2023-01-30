//
//  CourseDetailView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI
import RealmSwift

struct CourseDetailView: View {
    var registeredCourse:CourseDBModel
    var body: some View {
        VStack{
//            Text(registeredCourse.courseName)
            Form {
                Section("Couse Code \(registeredCourse.courseCode)") {
                    List {

                        CourseDetailItem(heading: "Course", headingValue: registeredCourse.courseName)
                        LabeledContent("Department", value: registeredCourse.department)
                        
                        LabeledContent("Credit", value: registeredCourse.courseCredit)
                        
                        LabeledContent("Course Year", value: registeredCourse.courseYear)
                        CourseDetailItem(heading: "Semestor", headingValue: registeredCourse.courseSemester)
                        
                        LabeledContent("Instructor") {
                            if(registeredCourse.instructors.isEmpty){
                                Text("None")
                            }else{
                                Text("\(registeredCourse.instructors[0].teacherName)")
                            }
                        }
                        LabeledContent("Description", value: registeredCourse.courseDescription)
                    }
                }
            }

        }
        .navigationTitle(registeredCourse.courseName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct CourseDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseDetailView(course: .init(courseInstructor: "Dr. Abhishek Verma", courseName: "Software Defined Networking", courseCode: "OE304", sem: "5", year: "2022"))
//    }
//}

struct CourseDetailItem: View {
    let heading:String
    let headingValue:String
    var body: some View {
        HStack{
            Text("\(heading)")
            Spacer()
            Text("\(headingValue)")
                .foregroundColor(.secondary)
        }
    }
}
