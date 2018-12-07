//
//  Record.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import Foundation
import RealmSwift

class Record : Object {
    
    @objc dynamic var recordId : Int = 0
    @objc dynamic var dataConsumed : Float = 0.0
    @objc dynamic var position : String = ""
    
    convenience init(json: [String : AnyObject]) {
        self.init()
        self.recordId = json["_id"] as? Int ?? 0
        if let quarter = json["quarter"] as? String {
            self.position = String(quarter.split(separator: "-")[1])
        }
        if let volumeData = json["volume_of_mobile_data"]?.floatValue {
            self.dataConsumed = volumeData
        }
    }
    
}
