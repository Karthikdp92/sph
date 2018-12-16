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
    
    /**
     Setup the realm database with default configuration.
     - Parameters:
        - Nothing
     - returns: Nothing
     */
    class func setupRealm() {
        if let realm = try? Realm(){
            var config = realm.configuration
            config.encryptionKey = Constants.realmEncryptionKey.data(using: String.Encoding.utf8)
            config.deleteRealmIfMigrationNeeded = true
            
        }
    }
    
    /**
     Adds usage detail record into the realm database
     - Parameters:
        - usageDetail : Usage detail for the year
     - returns: Nothing
     */
    class func addUsageDetail(usageDetail: UsageDetail) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.add(usageDetail)
            }
        }
    }
    
    /**
     Get usage detail record from realm database
     - Parameters:
        - year : Required only if fetching usage details for a specific year
     - returns: List of UsageDetail
     */
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
    
    /**
     Update usage detail present in realm database
     - Parameters:
        - usageDetail : Details to be updated
     - returns: Nothing
     */
    class func updateUsageDetail(usageDetail: UsageDetail) {
        if let realm = try? Realm() {
            let usageDetailCache = realm.objects(UsageDetail.self).filter{ $0.year == usageDetail.year }.first
            try? realm.write {
                usageDetailCache?.dataVolume = usageDetail.dataVolume
                usageDetailCache?.records = usageDetail.records
            }
        }
    }
    
    /**
     Clears the records available in realm database
     - Parameters:
        - Nothing
     - returns: Nothing
     */
    class func clearDataUsageCache() {
        if let realm = try? Realm() {
            try? realm.write {
                realm.deleteAll()
            }
        }
    }
    
}
