//
//  RealmHandler.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
final class RealmHandler:ObservableObject{
    let realmManager:RealmManager = RealmManager.shared
    @Published var realmLoading:Bool = true
    init(){
        self.realmManager.delegate = self
    }
    func fetchData(){
        //TODO: Fetch Data and Other Things..
    }
}

extension RealmHandler:RealmManagerDelegate{
    func didRealmLauched(value: Bool) {
        if(value){
            DispatchQueue.main.async {
                self.realmLoading = false
            }
        }
        self.fetchData()
    }
    
    func didAuthenticationFailed() {
        //Show Alert
    }
    
    func didRealmFailedToLauch(_ error: Error) {
        //Show Alert
    }
    
    func didConfigurationErrorOccured() {
        //Show Alert
    }
}
