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
    let realmManager:RealmManager = RealmManager.shared
    private let broadcastingService:BroadcastingService = BroadcastingService()
    var timer:Timer?
    
    @Published var isBroadcasting:Bool = false
    
    @Published var progressDescription:String = "Idle"
    @Published var bluetoothState:String = "Fetching..."
    
    @Published var attendanceProcessCompleted:Bool = false
    @Published var attendanceMarkedSucessfully:Bool = false
    
    @Published var attendancePIN:String = ""
    @Published var didStudentEnterPIN:Bool = false
    
    @Published var showAlert:Bool = false
    @Published var alertType:CustomErrorAlertProtocol = AttendanceDetailAlertError.none
    
    var cancellable=Set<AnyCancellable>()
    
    private var studentRollNumber:String{
        get{
//            return self.realmManager.fetchData(StudentDBModel.self).map{ $0.rollNumber}[0]
            return "20bec043"
        }
    }
    
    private var registeredCourseServiceIDs:[CBUUID]{
        get{
//            return self.realmManager.fetchData(CourseDBModel.self).map{ CBUUID(string: $0.serviceUUID) }
            return [Constants.SERVICE_UUID]
        }
    }
    private var studentName:String{
        get{
//            return self.realmManager.fetchData(StudentDBModel.self).map{ $0.studentName}.first!
            return "Harsh"
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
    var count = 0
    func sendData(_ interval:Double=2,confrimationResponse:Bool){
        print("Sending Data: \(count)")
        count += 1
        if(confrimationResponse){
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(broadcastDataWithConfirmationResponse), userInfo: nil, repeats: true)
        }else{
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(broadcastDataWithoutConfirmationResponse), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func broadcastDataWithConfirmationResponse(){
        if(self.attendanceProcessCompleted){
            stopSending()
        }else{
            if(self.didStudentEnterPIN){
                print("Broadcasting Data ☢️ with Confrimation Respone 🍬")
                self.broadcastingService.sendData(data: BroadcastedDataModel(studentName: self.studentName,
                                                                             rollNumber: self.studentRollNumber,
                                                                             pin: self.attendancePIN, confirmationResponse: true))
            }
        }
    }
    
    @objc private func broadcastDataWithoutConfirmationResponse(){
        if(self.attendanceProcessCompleted){
            stopSending()
        }else{
            if(self.didStudentEnterPIN){
                print("Broadcasting Data ☢️ without Confrimation Response ⛄︎")
                self.broadcastingService.sendData(data: BroadcastedDataModel(studentName: self.studentName,
                                                                             rollNumber: self.studentRollNumber,
                                                                             pin: self.attendancePIN, confirmationResponse: false))
            }
        }
    }

    private func stopSending(){
        self.timer?.invalidate()
    }
    
    func checkPIN(){
        if(self.attendancePIN.count != 4){
//            self.alertMessage = "Enter Valid PIN"
//            self.showAlert = true
        }else{
            self.didStudentEnterPIN = true
        }
    }
    
    
    
    private func saveAttendanceRecord(responseData:ScannedServiceDataModel){
        guard let dbRef = self.realmManager.realm else{
            return
        }
        
        let course = dbRef.objects(CourseDBModel.self).filter{ $0.serviceUUID == "759aabaf-1ffa-4e7b-b511-1dd267e066b3"}[0]
        do{
            try dbRef.write {
                let attendance = ClassAttendanceDBModel()
                let record = StudentRecordDBModel()
                
                record.isPresent = responseData.markedAttendance
                record.email = "20bec043@iiitdmj.ac.in" //TODO: Fetch from DB
                record.logStatus = responseData.markedAttendance ? "Marked Successfully" : "Wrong PIN" //TODO: progress description?
                record.timeOfAttendane = Date.now
                
                attendance.attendanceRecord.append(record)
                attendance.date = Date.now
                
                course.courseAttendance.append(attendance)
            }
        }catch(let e){
            print(e)
            print("Error While Saving Record!")
        }
    }
}

extension AttendanceDetailViewModel:BroadcastingServiceDelegate{
    
    //Save Response to DB   Send Data Again
    //If recieved Response then Send Data Again with confirmationResponse => True
    func didReviceResponse(_ response: ScannedServiceDataModel) {
        //Save Response to DB
//        saveAttendanceRecord(responseData: response)
        
        //Send Confirmation Response, until Disconected
        if(response.markedAttendance == false){
            self.showAlert = true
            self.alertType = AttendanceDetailAlertError.wrongPIN
        }else{
            self.attendanceMarkedSucessfully = true
        }
        
        self.sendData(confrimationResponse: true)
        
        //Show Student Response, Attendance State (Marked or Not Marked)
        //TODO: Show Alert is User Entered Wrong PIN and Give option to enter pin!
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
        self.attendanceProcessCompleted = true
    }
    
    func didUpdateState(newState: String) {
        self.bluetoothState = newState
    }
    
    func didSubcribedTeacherDevice() {
        sendData(confrimationResponse: false)
    }
    
    func didUnSubcribedTeacherDevice() {
        //TODO: Stop Broadcasting & Stop Sending Data
        self.stopSending()
        self.broadcastingService.stopBroadcasting()
    }
}
