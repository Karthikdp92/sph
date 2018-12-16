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
    static let resourceId : String = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    static let noInternetFromCache : String = "No Internet connection available. Displaying the offline data available"
    static let noInternetNoCache : String = "No Internet connection available. No offline data available to display"
    static let serverError : String = "Unable to reach server. Please try after sometime."
    static let serverNotFoundError : String = "Could not connect to server."
    static let error : String = "Please try after sometime"
    static let realmEncryptionKey : String = "TveURqLYbegZHbHi4KOP3l5Xgo7vZ76yWUaA0DoHV2UJhqt3dUIpb7M206Pc5s69"

    // APIs
    func dataUsageApi(offset: Int, limit: Int, resourceId: String) -> String {
        return "https://data.gov.sg/api/action/datastore_search?offset=\(offset)&limit=\(limit)&resource_id=\(resourceId)"
    }
    
}
