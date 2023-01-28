//
//  CourseDetailView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct CourseDetailView: View {
    let course:CourseDetailModel
    var body: some View {
        VStack{
//            Text(course.courseName)
            Form {
                Section("Couse Code \(course.courseCode)") {
                    List {
                        CourseDetailItem(heading: "Instructor", headingValue: course.courseInstructor)
                        
                        CourseDetailItem(heading: "Course", headingValue: course.courseName)
                        
                        CourseDetailItem(heading: "Semestor", headingValue: course.sem)
                    }
                }
            }

        }
        .navigationTitle(course.courseName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: .init(courseInstructor: "Dr. Abhishek Verma", courseName: "Software Defined Networking", courseCode: "OE304", sem: "5", year: "2022"))
    }
}

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
