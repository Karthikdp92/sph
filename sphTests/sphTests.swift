//
//  sphTests.swift
//  sphTests
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import XCTest
import RealmSwift
import Hippolyte
@testable import sph

class sphTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNormalAPICall() {
        let expectation = self.expectation(description: "Download data usage")
        var usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
            usageDetails = usageResponse
            assert(message == "Success")
            assert(usageDetails.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testStubForNotFound() {
        let url : URL = URL(string: Constants.sharedInstance.dataUsageApi(offset: 0, limit: 25, resourceId:  Constants.resourceId))!

        var stub = StubRequest(method: .GET, url: url)
        stub.response = StubResponse(statusCode: 404)
        stub.response.body = self.getJsonForStub(error: "NotFound")
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Server Not Found")
        let usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
            assert(message == Constants.serverNotFoundError)
            assert(usageDetails.count == 0)
            self.removeStub()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        
    }
    
    func testStubForInternalServerError() {
        let url : URL = URL(string: Constants.sharedInstance.dataUsageApi(offset: 0, limit: 25, resourceId:  Constants.resourceId))!

        var stub = StubRequest(method: .GET, url: url)
        stub.response = StubResponse(statusCode: 500)
        stub.response.body = self.getJsonForStub(error: "ServerError")
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Server Not Found")
        let usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
            assert(message == Constants.serverError)
            assert(usageDetails.count == 0)
            self.removeStub()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func getJsonForStub(error: String) -> Data? {
        if let path = Bundle.main.path(forResource: error, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                return data
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func removeStub() {
        Hippolyte.shared.stop()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
