//
//  AttendanceDetailViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import Combine

enum AttendanceDetailAlertError:String{
    case none = ""
    case broadcastingError = "Error Occured While Broadcasting"
    case stopBroadcasting = "Do you want to Stop Broadcasting?"
    case wrongPIN = "Enter Correct PIN"
    case bluetoothOff = "Grand Permission & Turn On Bluetooth"
}


class AttendanceDetailViewModel:ObservableObject{
    let broadcastingService:BroadcastingService = BroadcastingService()
    var timer:Timer?
    
    @Published var isBroadcasting:Bool = false
    @Published var showAlert:Bool = false
    @Published var alertMessage:String = "Default Alert Message"
    
    @Published var progressDescription:String = "Idle"
    @Published var bluetoothState:String = "Fetching..."
    
    @Published var attendanceCompleted:Bool = false
    
    @Published var attendancePIN:String = ""
    @Published var didStudentEnterPIN:Bool = false
    
    var cancellable=Set<AnyCancellable>()
    init(){
        self.broadcastingService.delegate = self
        self.updateProgress()
    }
    
    func startBroadcasting(){
        self.checkPIN()
        if(self.didStudentEnterPIN){
            self.broadcastingService.startBroadcasting(rollNumber: "20bec043")
        }else{
            self.alertMessage = "Enter Valid PIN"
            self.showAlert = true
        }
    }
    
    func stopBroadcasting(){
        self.broadcastingService.stopBroadcasting()
    }
    
    ///Current process description
    ///Shows Alert when any thing goes wrong
    func updateProgress(){
        self.broadcastingService.progressDescription = { [weak self] progress in
            switch progress{
            case .success(let success):
                self?.progressDescription = success.rawValue
            case .failure(let error):
                self?.alertMessage = error.rawValue
                self?.showAlert = true
            }
        }
    }
    
    ///Sends Data every 1 second, time could to changed
    func sendData(_ interval:Double=1){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(automationFunction), userInfo: nil, repeats: true)
    }
    
    @objc func automationFunction(){
        if(self.attendanceCompleted){
            print("Firing Completed")
            timer?.invalidate()
        }else{
            if(self.didStudentEnterPIN){
                //TODO: Broadcasted Data/Student record must come from DB, not hardcoded
                self.broadcastingService.sendData(data: BroadcastedDataModel(studentName: "InsanelyHarsh", rollNumber: "20BEC043", pin: self.attendancePIN),
                                                  for: self.broadcastingService.charactertic!,
                                                  to: self.broadcastingService.subscribedCentrals)
            }
        }
    }
    
    func checkPIN(){
        if(self.attendancePIN.count != 4){
            self.alertMessage = "Enter Valid PIN"
            self.showAlert = true
        }else{
            self.didStudentEnterPIN = true
        }
    }
}

extension AttendanceDetailViewModel:BroadcastingServiceDelegate{
    func didReviceResponse(_ response: String) {
        self.attendanceCompleted = true
        self.alertMessage = response
        self.showAlert = true
    }
    
//    func broadcastingServiceProgressDescription(_ description: String) {
//        self.progressDescription = description
//    }
    
    func isReadytoStartBroadcasting() {
        //TODO
    }
    
    func didStartBroadcasting() {
        self.isBroadcasting = true
    }
    
    func didStopBroadcasting() {
        self.isBroadcasting = false
    }
    
    func didUpdateState(newState: String) {
        self.bluetoothState = newState
    }
    
    func didSubcribedTeacherDevice() {
        sendData()
    }
    
    func didUnSubcribedTeacherDevice() {
        //TODO: Stop Broadcasting..
    }
}
