//
//  AttendanceDetailViewModel.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
import Combine
import CoreBluetooth

class AttendanceDetailViewModel:ObservableObject{
    private let realmManager:RealmManager = RealmManager.shared
    private let broadcastingService:BroadcastingService = BroadcastingService()
    var timer:Timer?
    
    @Published var isBroadcasting:Bool = false
    
    @Published var progressDescription:String = "Idle"
    @Published var bluetoothState:String = "Fetching..."
    
    @Published var attendanceCompleted:Bool = false
    
    @Published var attendancePIN:String = ""
    @Published var didStudentEnterPIN:Bool = false
    
    @Published var showAlert:Bool = false
    @Published var alertType:CustomErrorAlertProtocol = AttendanceDetailAlertError.none
    
    var cancellable=Set<AnyCancellable>()
    
    private var studentRollNumber:String{
        get{
            return self.realmManager.fetchData(StudentDBModel.self).map{ $0.rollNumber}[0]
        }
    }
    
    private var registeredCourseServiceIDs:[CBUUID]{
        get{
            return self.realmManager.fetchData(CourseDBModel.self).map{ CBUUID(string: $0.serviceUUID) }
        }
    }
    private var studentName:String{
        get{
            return self.realmManager.fetchData(StudentDBModel.self).map{ $0.studentName}.first!
        }
    }
    
    init(){
        self.broadcastingService.delegate = self
        self.updateProgress()
    }
    
    //TODO: Broadcast to all the Teacher (or) Ask Student, specific course and mark attendance
    func startBroadcasting(){
        self.checkPIN()
        if(self.didStudentEnterPIN){
            self.broadcastingService.startBroadcasting(of: self.registeredCourseServiceIDs, rollNumber: self.studentRollNumber)
        }else{
            self.alertType = AttendanceDetailAlertError.wrongPIN
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
//                self?.alertMessage = error.rawValue //TODO: Fix this error
                self?.alertType = error 
                self?.showAlert = true
            }
        }
    }
    
    ///Sends Data every 1 second, time could to changed
    func sendData(_ interval:Double=2){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(automationFunction), userInfo: nil, repeats: true)
    }
    
    @objc private func automationFunction(){
        if(self.attendanceCompleted){
            print("Broadcasting Data ☢️")
            timer?.invalidate()
        }else{
            if(self.didStudentEnterPIN){
                self.broadcastingService.sendData(data: BroadcastedDataModel(studentName: self.studentName,
                                                                             rollNumber: self.studentRollNumber,
                                                                             pin: self.attendancePIN))
                
//                self.broadcastingService.sendData(data: BroadcastedDataModel(studentName: "InsanelyHarsh", rollNumber: "20BEC043", pin: self.attendancePIN),
//                                                  for: self.broadcastingService.charactertic!,
//                                                  to: self.broadcastingService.subscribedCentrals)
            }
        }
    }
    
    func checkPIN(){
        if(self.attendancePIN.count != 4){
//            self.alertMessage = "Enter Valid PIN"
//            self.showAlert = true
        }else{
            self.didStudentEnterPIN = true
        }
    }
}

extension AttendanceDetailViewModel:BroadcastingServiceDelegate{
    func didReviceResponse(_ response: Bool) {
        if(response){
            self.broadcastingService.stopBroadcasting()
            Logger.logMessage("Stopping Broadcasting")
            
            
//            realmManager.add(<#T##item: T##T#>)
            self.attendanceCompleted = true
            //TODO: Save Response to DB, Here.....
        }else{
            //TODO: Save Response & Failure Reason!
            
        }
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
