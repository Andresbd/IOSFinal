//
//  InterfaceController.swift
//  iwatch Extension
//
//  Created by Dario Bonifaz on 11/24/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
    }
    
    var session: WCSession!
    
    
    //Variables
    var salonT:String = ""

    //Oulets
    @IBOutlet var salonW: WKInterfaceLabel!
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self as! WCSessionDelegate
            session.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        salonW.setText(message[("message" as? String)!] as! String)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
