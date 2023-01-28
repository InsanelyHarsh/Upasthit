//
//  RealmManager.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import RealmSwift

protocol RealmManagerDelegate{
    func didRealmLauched(value:Bool)
    
    func didAuthenticationFailed()
    func didRealmFailedToLauch(_ error:Error)
    func didConfigurationErrorOccured()
}

final class RealmManager{
    let app:App
    var user:User?
    var config:Realm.Configuration?
    var realm:Realm?
    static let shared:RealmManager = RealmManager()
    
    var delegate:RealmManagerDelegate?
    
    init(){
        app = App(id: "realm-basics-swiftui-tpmjz")
    }
    
    //Step 01 : Login User
    func authUser() async { //TODO: Replace anonymous Method
        do{
            self.user = try await app.login(credentials: .anonymous)
            print("Auth Done!")
        }catch(let err){
            print("User Login Failed!")
            print("Error: \(err)\n\n")
            
            self.delegate?.didAuthenticationFailed()
        }
        await configurationSetup()
    }
    
    //Step 02 : Set Flexible Sync Configuration
    func configurationSetup() async{

        guard let user = self.user else {
            print("Can't find User!")
            return
        }
        
        /*
        self.config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
            print("\n\n \(subs) \n\n")
            if let _ = subs.first(named: "ITEM_MODEL_SUBSCRIPTION"){
                return
            }else{
                subs.append(QuerySubscription<ItemModel>(name: "ITEM_MODEL_SUBSCRIPTION"))
                subs.append(QuerySubscription<GroupModel>(name: "ITEM_MODEL_SUBSCRIPTION"))
//                subs.append(QuerySubscription(name: "detail-db"))
            }
        }, rerunOnOpen: false)
        */
        
        self.config = user.flexibleSyncConfiguration(initialSubscriptions: { _ in //No Initial Configuration
            return
        }, rerunOnOpen: false)
        
        guard let config = config else {
            self.delegate?.didConfigurationErrorOccured()
            return
        }
        
        await launchRealm(with: config)
    }
    
    //Step 03 : Init Realm and Add Subs(Can add subs on step02 also)
    @MainActor
    func launchRealm(with config:Realm.Configuration?)async{
        do{
            self.realm = try await  Realm(configuration: config!, downloadBeforeOpen: .never)
            
            print("Realm Launched!")
            self.delegate?.didRealmLauched(value: true)
            if(realm?.subscriptions.count == 0){
                await self.addSubcription(ItemModel(), name: "ITEM_MODEL_SUBSCRIPTION")
                await self.addSubcription(GroupModel(), name: "GROUP_MODEL_SUBSCRIPTION")
            }
        }catch(let error){
            print("Realm Failed! \n Error:\(error)")
            self.delegate?.didRealmFailedToLauch(error)
        }
    }
    
    
    func addSubcription<T:Object>(_ object:T,name:String?)async{
        guard let realm = self.realm else {
            print("Error: Found Realm Nil!")
            return
        }
        
        let subscriptions = realm.subscriptions
        
        do{
            try await subscriptions.update {
                let itemSub = QuerySubscription<T>(name: name)
                subscriptions.append(itemSub)
            }
        }catch(let error){
            print("\n\n Failed during Adding Item Subscriptions. Error: \(error.localizedDescription)")
            print("Error: \(error) \n\n")
        }
    }
}


extension RealmManager{
    ///Fetch Data Function returns Array of Frozen Values
    func fetchData<T:Object>(_ type:T.Type)->[T]{

        guard let dbRef = realm else { return [] }
        let result = dbRef.freeze().objects(T.self) //frozen Result
        return result.compactMap{$0}
    }
    

    
    func add<T:Object>(_ item: T) {
        
        guard let dbRef = realm else { return }
        do{ //TODO: try async?
            try dbRef.write({ //Only non-frozen Values
                dbRef.add(item)
            })
        }catch(let error){
            print("Error While Adding Item: \(T.Type.self)")
            print("Error Description: \(error.localizedDescription)")
            print(error)
        }
    }
    
    //TODO: Add Update Function
}




final class GroupModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId
    
    @Persisted var groupTitle:String
    @Persisted var items = List<ItemModel>() //Array of ItemModel
    
    convenience init(groupTitle:String){
        self.init()
        self.groupTitle = groupTitle
    }
}

final class ItemModel:Object,ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var _id:ObjectId
    @Persisted var name:String
    @Persisted var isFav:Bool = false
    
    
    @Persisted(originProperty: "items") var groupModel:LinkingObjects<GroupModel>
    
    convenience init(name:String){
        self.init()
        self.name = name
    }
}
