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
    
    convenience init(record: Record) {
        self.init()
        self.dataVolume = record.dataConsumed
        self.isAlertRequired = false
        self.records.append(record)
    }
    
    func addRecord(record: Record) {
        if let realm = try? Realm() {
            try? realm.write {
                self.records.append(record)
                self.calculateDataConsumed()
            }
        }
    }
    
    func calculateDataConsumed() {
        let sortedRecords = self.records.sorted(by: { $0.position < $1.position })
        var data : Float = 0.0
        
        for (index, record) in sortedRecords.enumerated() {
            data += record.dataConsumed
            if index != 0 {
                if record.dataConsumed - self.records[index - 1].dataConsumed < 0 {
                    self.isAlertRequired = true
                }
            }
        }
        self.dataVolume = data
    }
    
}
