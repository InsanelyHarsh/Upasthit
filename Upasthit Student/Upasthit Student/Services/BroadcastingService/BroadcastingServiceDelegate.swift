//
//  BroadcastingServiceDelegate.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import Foundation
protocol BroadcastingServiceDelegate{
    func isReadytoStartBroadcasting()
    
    func didStartBroadcasting() //
    
    func didStopBroadcasting() //
    
    func didUpdateState(newState:String) //
    
    func didSubcribedTeacherDevice() //
    func didUnSubcribedTeacherDevice()
    
    //    func didReviceResponse(_ response:String)
    func didReviceResponse(_ response:Bool) //
    
//    func broadcastingServiceProgressDescription(_ description:String)
}
