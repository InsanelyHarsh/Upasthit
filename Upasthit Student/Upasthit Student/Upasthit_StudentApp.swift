//
//  Upasthit_StudentApp.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

@main
struct Upasthit_StudentApp: App {
//    @StateObject var realmHandler:RealmHandler = RealmHandler()
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear{
                    Logger.logLine()
                    Logger.logMessage("\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)")
                    Logger.logLine()
                }
        }
    }
}
