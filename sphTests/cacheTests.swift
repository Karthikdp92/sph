//
//  cacheTests.swift
//  sphTests
//
//  Created by Nanjundaswamy Sainath on 15/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import XCTest
@testable import sph

class cacheTests: XCTestCase {
    
    var record : Record? = nil
    var usageDetail : UsageDetail? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let json = ["volume_of_mobile_data":"0.000384", "quarter":"2004-Q3", "_id":1] as [String : AnyObject]
        self.record = Record(json: json)
        self.usageDetail = UsageDetail(record: self.record!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        CacheManager.clearDataUsageCache()
    }

    func testCacheManager() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.addUsageDetails()
        self.getUsageDetails()
        self.getUsageDetailsByYear(year: 2004)
    }

    func addUsageDetails() {
        CacheManager.addUsageDetail(usageDetail: self.usageDetail!)
    }
    
    func getUsageDetails() {
        let _ = CacheManager.getUsageDetailsList()
    }
    
    func getUsageDetailsByYear(year: Int) {
        let _ = CacheManager.getUsageDetailsList(year: year)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
