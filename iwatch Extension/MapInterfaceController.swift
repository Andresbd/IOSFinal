//
//  MapInterfaceController.swift
//  iwatch Extension
//
//  Created by Dario Bonifaz on 11/25/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import WatchKit
import Foundation


class MapInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    @IBOutlet var mapa: WKInterfaceMap!
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let tec=CLLocationCoordinate2D(latitude: 19.283996, longitude: -99.136006)
        let region=MKCoordinateRegion(center:tec, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapa.setRegion(region)
        self.mapa.addAnnotation(tec, with: .purple)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
