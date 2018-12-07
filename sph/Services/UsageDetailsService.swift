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
    
    class func DownloadUsageDetails(usageDetails: List<UsageDetail>, offset: Int, limit: Int, resourceId: String, callBack:@escaping (Bool, Bool, String, List<UsageDetail>) -> Void) -> Void {
        var usageDetailsResponse = List<UsageDetail>()
        if !NetworkManager.isConnected() {
            usageDetailsResponse = CacheManager.getUsageDetailsList()
            if usageDetailsResponse.count > 0 {
                callBack(true, false, Constants.sharedInstance.noInternetFromCache(), usageDetailsResponse)
                return
            }
            callBack(false, false, Constants.sharedInstance.noInternetNoCache(), usageDetailsResponse)
            return
        }
        var request = URLRequest(url: URL(string: Constants.sharedInstance.dataUsageApi(offset: offset, limit: limit, resourceId: resourceId))!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let status = json["success"] as? NSNumber ?? 0
                if status == 1 {
                    if let result = json["result"] as? Dictionary<String, AnyObject> {
                        usageDetailsResponse = UsageDetailsParser.parse(json: result, usageDetails: usageDetails)
                        callBack(false, true, "Success", usageDetailsResponse)
                        return
                    }
                }
                callBack(false, false, Constants.sharedInstance.error(), usageDetailsResponse)
            } catch {
                callBack(false, false, Constants.sharedInstance.error(), usageDetailsResponse)
            }
        }).resume()
    }
    
}
