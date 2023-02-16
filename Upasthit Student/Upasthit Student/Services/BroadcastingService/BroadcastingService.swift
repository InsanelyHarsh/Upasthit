//
//  BroadcastingService.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import CoreBluetooth
import Combine

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
    
    var broadcastingServiceBluetoothState:CurrentValueSubject<String,Never> = CurrentValueSubject<String,Never>("Idle")
    
    override init(){
        super.init()
        self.scannedDeviceManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    
    //MARK: - Start Broadcasting & Stop Broadcasting
    
    ///Start Broadcasting
    ///- This function starts BLE Broadcasting. By default it broadcast  [Constants.SERVICE_UUID]
    ///- Roll Number is the name of Device
    func startBroadcasting(of services:[CBUUID] = [Constants.SERVICE_UUID],rollNumber:String){ //MARK: roll works and Broadcasting Name!
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
}



//MARK: - Send Data
extension BroadcastingService{
    
    //NOTE: Sending Data to Subcribed Central Devices. Will be Handled by VM,not Broadcasting Service Class
    ///Send Data after Teacher device is connected and Subscribed.
    ///Previous Arg: ,for characteristic:CBMutableCharacteristic,to centrals:[CBCentral]?
    func sendData(data dataBroadcasted:BroadcastedDataModel){
        //Encoding Data
        guard let encodedBroadcastData = encodeData(dataBroadcasted) else{
            self.progressDescription?(.failure(.encodingFailed))
            return
        }
        
        //Sending Updated Data
//        self.scannedDeviceManager.updateValue(encodedBroadcastData, for: characteristic, onSubscribedCentrals: centrals)
        
        
        self.scannedDeviceManager.updateValue(encodedBroadcastData, for: self.charactertic!, onSubscribedCentrals: self.subscribedCentrals)
        
        self.progressDescription?(.success(.checkingCredentails))
    }
}




extension BroadcastingService:CBPeripheralManagerDelegate{
    
    //Did Update State
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        self.progressDescription?(.success(.bleStateUpdated))
        
        self.broadcastingServiceBluetoothState.send(BroadcastingServiceStateDescription(rawValue: peripheral.state.rawValue)!.stateDescription)
    }

    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        guard error == nil else{
            self.progressDescription?(.failure(.broadcastingError))
            return
        }
        
        self.delegate?.didStartBroadcasting()
        self.progressDescription?(.success(.broadcastingStarted))
    }
    
    
    
    //TODO: You can then implement this delegate method to resend the value.
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
//        self.sendData(for: self.charactertic!, to: subscribedCentrals)
        //
    }
    
 
    
    
    //Did Write
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        self.progressDescription?(.success(.readingTeacherResponse))
        
        for request in requests{
            guard let data = request.value else {
                return
            }
            
            do{
                //Decoding Response
                let decodedResponse = try JSONDecoder().decode(ScannedServiceDataModel.self, from: data)
                print("Decoded Response: \(decodedResponse)")
                self.delegate?.didReviceResponse(decodedResponse)
            }catch{
                print("TODO: Handle this error")
                self.progressDescription?(.failure(.readingResponseFailed))
            }

            
            Logger.logMessage("Recieved Write on \(request.characteristic.uuid)")
            Logger.logMessage("Central: \(request.central.identifier)")
            Logger.logMessage("Data: \(String(data: data, encoding: .utf8) ?? "nil")")
            Logger.logLine()
        }
    }
}



//MARK: - Subcribe & Unsubscribe Central Device
extension BroadcastingService{
    
    //Did Subscribe
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        self.subscribedCentrals.append(central)
        
        //Sending Data handled by VM
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
}






//MARK: - Utility Methods
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
