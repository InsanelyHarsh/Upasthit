//
//  BroadcastingService.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import CoreBluetooth
/*
 >> Subcribed to 7D85B16C-D99D-EFE2-2AEE-48C2DAF3C073
 >> Subcribed to E763C3B5-21F6-E269-6589-AE0505B4EDDF
 */

class BroadcastingService:NSObject{
    
    private var scannedDeviceManager:CBPeripheralManager!
    
    var charactertic:CBMutableCharacteristic?
    var subscribedCentrals:[CBCentral] = []
    
    var progressDescription:((Result<BroadcastingServiceProgressDescription,BroadcastingServiceErrorDescription>)->Void)?
    var delegate:BroadcastingServiceDelegate?
    
    override init(){
        super.init()
        self.scannedDeviceManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    
    
    //Start Broadcasting
    ///This function starts BLE Broadcasting. By default it broadcast  [Constants.SERVICE_UUID]
    ///Roll Number is the name of Device
    func startBroadcasting(of services:[CBUUID] = [Constants.SERVICE_UUID],rollNumber:String){
        if(!self.scannedDeviceManager.isAdvertising){
            
            if(scannedDeviceManager.state == .poweredOn){
                
                //Create Service
                self.createService(with: Constants.CHAR_UUID, of: services[0])
                
                //Start Advertising
                self.scannedDeviceManager.startAdvertising([CBAdvertisementDataLocalNameKey : rollNumber,
                                                         CBAdvertisementDataServiceUUIDsKey : services])
                
            }else{
                self.progressDescription?(.failure(.bluetoothIsTurnedOff))
                self.scannedDeviceManager.stopAdvertising()
            }
            
        }else{
            self.stopBroadcasting()
        }
    }
    
    
    
    //Stop Broadcasting
    func stopBroadcasting(){
        self.scannedDeviceManager.stopAdvertising()
        self.delegate?.didStopBroadcasting()
        self.progressDescription?(.success(.broadcastingStopped))
    }
    
    
    
    //MARK: Send Data
    ///Send Data after Teacher device is connected and Subscribed.
    func sendData(data dataBroadcasted:BroadcastedDataModel,for characteristic:CBMutableCharacteristic,to centrals:[CBCentral]?){
        //Encoding Data
        guard let encodedBroadcastData = encodeData(dataBroadcasted) else{ return }
        
        //Sending Updated Data
        self.scannedDeviceManager.updateValue(encodedBroadcastData, for: characteristic, onSubscribedCentrals: centrals)
        
        self.progressDescription?(.success(.checkingCredentails))
    }
}





extension BroadcastingService:CBPeripheralManagerDelegate{
    
    //Did Update State
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        self.progressDescription?(.success(.bleStateUpdated))
        switch peripheral.state{
        case .unknown:
            self.delegate?.didUpdateState(newState: "Unknown State")
        case .resetting:
            self.delegate?.didUpdateState(newState: "Resetting Peripheral State")
        case .unsupported:
            self.delegate?.didUpdateState(newState: "UnSupported State")
        case .unauthorized:
            self.delegate?.didUpdateState(newState: "Unauthorized State")
        case .poweredOff:
            self.delegate?.didUpdateState(newState: "Powered Off State")
        case .poweredOn:
            self.delegate?.didUpdateState(newState: "Bluetooth State has been Updated. Ready to Broadcast ✅")
            self.delegate?.isReadytoStartBroadcasting()
        @unknown default:
            self.delegate?.didUpdateState(newState: "Unknown State")
        }
    }
    
    
    
    
    
    
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        guard error == nil else{
            self.progressDescription?(.failure(.broadcastingError))
            return
        }
        self.delegate?.didStartBroadcasting()
        self.progressDescription?(.success(.broadcastingStarted))
    }
    
    
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
//        self.sendData(for: self.charactertic!, to: subscribedCentrals)
        //
    }
    
    
    
    
    
    
    
    //Did Subscribe
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        self.subscribedCentrals.append(central)
//        self.sendData(for: self.charactertic!, to: [central])
        
        self.delegate?.didSubcribedTeacherDevice()
        self.progressDescription?(.success(.connectionMadeWithTeacherDevice))
        
        Logger.logMessage("Subcribed to \(central.identifier)")
    }
    
    
    
    //Did UnSubscribe
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        Logger.logMessage("Unsubcribed to \(central.identifier)")
        self.delegate?.didUnSubcribedTeacherDevice()
    }
    
    
    
    
    
    
    
    
    //Did Write
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        self.progressDescription?(.success(.readingTeacherResponse))
        for i in requests{
            guard let data = i.value else {
                return
            }
//            self.delegate?.didReviceResponse("Congrats your Attendance has been Marked 🥳.\n Look What Teacher send: \(String(data: data, encoding: .utf8) ?? "nil")")
            
            do{
                let d = try JSONDecoder().decode(ScannedServiceDataModel.self, from: data)
                if(d.markedAttendance){
                    self.delegate?.didReviceResponse("Congrats your Attendance has been Marked 🥳")
                }else{
                    self.delegate?.didReviceResponse("❌ Invalid PIN, Try Again!")
                }
            }catch{
                print("TODO: Handle this error")//TODO: More Neat
            }

            
            Logger.logMessage("Recieved Write on \(i.characteristic.uuid)")
            Logger.logMessage("Central: \(i.central.identifier)")
            Logger.logMessage("Data: \(String(data: data, encoding: .utf8) ?? "nil")")
            Logger.logLine()
            
            //TODO: check response and then stop Broadcasting..
            Logger.logMessage("Stopping Broadcasting")
            self.stopBroadcasting()
            Logger.logLine()
        }
    }
}












extension BroadcastingService{
    
    /*
     Broadcast
     Service -- UUID
        Char -- UUID
     */
    private func createService(with charID:CBUUID,of serviceID:CBUUID) {

        
        //Creating Characteristic,using Data that have to be broadcasted
        let broadcastCharacteristic = self.createCharacteristic(with: charID)
        self.charactertic = broadcastCharacteristic //storing charactertics
        
        //Creating Service
        let broadcastService = CBMutableService(type: serviceID, primary: true)
        
        //Adding Characteristic to Service
        broadcastService.characteristics = [broadcastCharacteristic]
        
        //Adding Service
        scannedDeviceManager?.add(broadcastService)
    }
    
    
    private func encodeData<T:Encodable>(_ data:T)->Data?{
        let encoder = JSONEncoder()
        do{
            return try encoder.encode(data)
        }catch{
            return nil
        }
    }
    
    private func createCharacteristic(with id:CBUUID,data:BroadcastedDataModel? = nil)->CBMutableCharacteristic{
        return CBMutableCharacteristic(type: id,
                                       properties: [.write,.read,.notify],
                                       value: nil,
                                       permissions: [.readable,.writeable])
    }
}