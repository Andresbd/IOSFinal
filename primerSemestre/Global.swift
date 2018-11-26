//
//  Global.swift
//  primerSemestre
//
//  Created by Luis Eduardo Brime Gomez on 11/26/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

class Global {
    var user : String = ""
    
    class var sharedManager : Global {
        struct Static {
            static let instance = Global()
        }
        return Static.instance
    }
}
