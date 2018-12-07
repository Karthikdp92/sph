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
    func noInternet() -> String {
        return "No internet connection available"
    }
    
    // APIs
    func dataUsageApi(offset: Int, limit: Int, resourceId: String) -> String {
        return "https://data.gov.sg/api/action/datastore_search?offset=\(offset)&limit=\(limit)&resource_id=\(resourceId)"
    }
    
}
