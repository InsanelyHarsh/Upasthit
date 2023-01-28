//
//  HomeView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var courseManager:CourseDetailManager = CourseDetailManager()
    
    var body: some View {
        VStack{
            //MARK: Registered Courses
            Form{
                Section {
                    ForEach(courseManager.registeredCourses, id: \.id) { course in
                        NavigationLink(value: course) {
                            Text("\(course.courseName)")
                        }
                    }
                } header: {
                    Text("Registered courses")
                }
            }
        }
        .onAppear{
            self.courseManager.getCourseList() //Fetch Course List
        }
        .navigationDestination(for: CourseDetailModel.self, destination: { course in
            CourseDetailView(course: course)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RouteManager())
    }
}
