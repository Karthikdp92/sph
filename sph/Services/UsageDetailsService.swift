//
//  UsageDetailsService.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import Foundation
import RealmSwift

class UsageDetailsServices : NSObject {
    
    /**
     Service method which handles the API call
     - Parameters:
        - usageDetails : Usage details available
        - offset : Current offset value for pagination
        - limit : Limit of records to be fetched
        - resourceId : Unique id whose data usage details to be viewed
     - returns: List of UsageDetail
     */
    class func DownloadUsageDetails(usageDetails: List<UsageDetail>, offset: Int, limit: Int, resourceId: String, callBack:@escaping (Bool, Bool, String, List<UsageDetail>) -> Void) -> Void {
        
        var usageDetailsResponse = List<UsageDetail>()
        if !NetworkManager.isConnected() {
            usageDetailsResponse = CacheManager.getUsageDetailsList()
            if usageDetailsResponse.count > 0 {
                callBack(true, false, Constants.noInternetFromCache, usageDetailsResponse)
                return
            }
            callBack(false, false, Constants.noInternetNoCache, usageDetailsResponse)
            return
        }
        var request = URLRequest(url: URL(string: Constants.sharedInstance.dataUsageApi(offset: offset, limit: limit, resourceId: resourceId))!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    callBack(false, false, error?.localizedDescription ?? Constants.error, usageDetailsResponse)
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    
                    guard let json = try? JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>, let status = json["success"] as? Int else {
                        callBack(false, false, Constants.error, usageDetailsResponse)
                        return
                    }
                    
                    if status == 1 {
                        
                        DispatchQueue.main.async {
                            
                            if let result = json["result"] as? Dictionary<String, AnyObject> {
                                usageDetailsResponse = UsageDetailsParser.parse(json: result, usageDetails: usageDetails)
                                callBack(false, true, "Success", usageDetailsResponse)
                                return
                            } else {
                                callBack(false, false, Constants.error, usageDetailsResponse)
                            }
                        }
                    }
                }
                else if httpResponse.statusCode == 500 {
                    callBack(false, false, Constants.serverError, usageDetailsResponse)
                }
                else if httpResponse.statusCode == 404 {
                    callBack(false, false, Constants.serverNotFoundError, usageDetailsResponse)
                }
                else {
                    callBack(false, false, Constants.error, usageDetailsResponse)
                }
            }
            
        }).resume()
    }
    
}
