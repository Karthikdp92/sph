//
//  UsageDetail.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import Foundation
import RealmSwift

class UsageDetail : Object {
    
    @objc dynamic var year : Int = 0
    @objc dynamic var dataVolume : Float = 0.0
    @objc dynamic var isAlertRequired : Bool = false
    
    var records = List<Record>()
    
    override static func primaryKey() -> String? {
        return "year"
    }
    
}
