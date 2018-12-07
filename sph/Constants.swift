//
//  Constants.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import Foundation

class Constants {
    
    static let sharedInstance = Constants()
    
    // Messages
    func noInternetFromCache() -> String {
        return "No Internet connection available. Displaying the offline data available"
    }
    
    func noInternetNoCache() -> String {
        return "No Internet connection available. No offline data available to display"
    }
    
    func error() -> String {
        return "Please try after sometime"
    }
    
    //Keys
    func realmEncryptionKey() -> String {
        return "TveURqLYbegZHbHi4KOP3l5Xgo7vZ76yWUaA0DoHV2UJhqt3dUIpb7M206Pc5s69"
    }
    
    // APIs
    func dataUsageApi(offset: Int, limit: Int, resourceId: String) -> String {
        return "https://data.gov.sg/api/action/datastore_search?offset=\(offset)&limit=\(limit)&resource_id=\(resourceId)"
    }
    
}
