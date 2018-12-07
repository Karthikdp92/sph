//
//  CacheManager.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import Foundation
import RealmSwift

class CacheManager: NSObject {
    
    class func setupRealm() {
        if let realm = try? Realm(){
            var config = realm.configuration
            config.encryptionKey = Constants.sharedInstance.realmEncryptionKey().data(using: String.Encoding.utf8)
            config.deleteRealmIfMigrationNeeded = true
            
        }
    }
    
    class func addUsageDetail(usageDetail: UsageDetail) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.add(usageDetail)
            }
        }
    }
    
    class func getUsageDetailsList(year: Int? = nil) -> List<UsageDetail> {
        var usageDetails = List<UsageDetail>()
        if let realm = try? Realm() {
            if year != nil {
                let results = realm.objects(UsageDetail.self).filter {$0.year == year}
                usageDetails = results.reduce(List<UsageDetail>()) { (list, element) -> List<UsageDetail> in
                    list.append(element)
                    return list
                }
            } else {
                let results = realm.objects(UsageDetail.self)
                usageDetails = results.reduce(List<UsageDetail>()) { (list, element) -> List<UsageDetail> in
                    list.append(element)
                    return list
                }
            }
        }
        return usageDetails
    }
    
    class func updateUsageDetail(usageDetail: UsageDetail) {
        if let realm = try? Realm() {
            let usageDetailCache = realm.objects(UsageDetail.self).filter{ $0.year == usageDetail.year }.first
            try? realm.write {
                usageDetailCache?.dataVolume = usageDetail.dataVolume
                usageDetailCache?.records = usageDetail.records
            }
        }
    }
    
    class func clearDataUsageCache() {
        if let realm = try? Realm() {
            try? realm.write {
                realm.deleteAll()
            }
        }
    }
    
}
