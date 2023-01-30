//
//  HomeView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI
//import RealmSwift

struct HomeView: View {
    
//    @StateObject var courseManager:CourseDetailManager = CourseDetailManager()
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    
    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            if(self.homeVM.registeredCourseList.count == 0){
//                Text("No Registered Courses")
//            }
            //MARK: Registered Courses
            Form{
                Section {
//                    Text("...^")
                    ForEach(homeVM.registeredCourseList, id: \.id) { course in
                        NavigationLink(value: course) {
                            Text("\(course.courseName)")
                        }
                    }
                } header: {
                    Text("Registered courses")
                }
            }
//        }
        .onAppear{
            self.homeVM.getCourseList() //Fetch Course List
        }
        .navigationDestination(for: CourseDBModel.self, destination: { course in
            CourseDetailView(registeredCourse: course)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RouteManager())
    }
}
