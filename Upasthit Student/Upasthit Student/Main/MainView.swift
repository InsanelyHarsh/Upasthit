//
//  MainView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var realmHandler:RealmHandler = RealmHandler()
    
    @StateObject var routeManger:RouteManager = RouteManager()
    @StateObject var tabManager:TabManager = TabManager()
    
    @State var showProfile:Bool = false
    var body: some View {
        NavigationStack(path: $routeManger.route){
            
            ZStack{
                if(self.realmHandler.realmLoading){
                    ProgressView("Setting Up Application...")
                }
                TabView(selection: $tabManager.currentTab){
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(TabRoutingViews.home)
                    
                    MarkAttendanceView()
                        .tabItem {
                            Label("Attedance", systemImage: "dot.radiowaves.left.and.right")
                        }
                        .tag(TabRoutingViews.attendance)
                    
                    SettingsView()
                        .tabItem {
                            Label("Setting", systemImage: "gear")
                        }
                        .tag(TabRoutingViews.settings)
                }
            }
            .onAppear{
                self.realmHandler.realmManager.launchRealm(with: nil)
            }
//            .task {
//                await self.realmHandler.realmManager.authUser()
//            }
            .fullScreenCover(isPresented: $showProfile, content: {
                ProfileView()
            })
            .environmentObject(routeManger)
            .navigationTitle(tabManager.currentTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showProfile = true
                    } label: {
                        Image(systemName: "person.circle.fill")
                    }.tint(.gray)
                    
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
