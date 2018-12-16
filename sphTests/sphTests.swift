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

extension XCTestCase{
    
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
}

class sphTests: XCTestCase {
    
//    func testNormalAPICall() {
//
//        let expectation = self.expectation(description: "Download data usage")
//        var usageDetails = List<UsageDetail>()
//        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
//            usageDetails = usageResponse
//            assert(message == "Success")
//            assert(usageDetails.count > 0)
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 20, handler: nil)
//    }
}


class sphNetworkError404: XCTestCase {
    
    override func setUp() {
        super.setUp()

        let url : URL = URL(string: Constants.sharedInstance.dataUsageApi(offset: 0, limit: 25, resourceId:  Constants.resourceId))!
        
        var stub = StubRequest(method: .GET, url: url)
        var response = StubResponse(error: NSError(domain: "com.sph.demo", code: 404, userInfo: [NSLocalizedDescriptionKey : Constants.serverNotFoundError]))
        response.body = self.getJsonForStub(error: "NotFound")
        stub.response = response
        
        Hippolyte.shared.clearStubs()
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        Hippolyte.shared.stop()
    }
    
    func testStubForNotFound() {
        
        let expectation = self.expectation(description: "Server Not Found")
        let usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
            if(message == Constants.serverNotFoundError){
                assert(message == Constants.serverNotFoundError)
                assert(usageDetails.count == 0)
                Hippolyte.shared.stop()
                URLSession.shared.invalidateAndCancel()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
}

class sphNetworkError500: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let url : URL = URL(string: Constants.sharedInstance.dataUsageApi(offset: 0, limit: 25, resourceId:  Constants.resourceId))!
        var stub = StubRequest(method: .GET, url: url)
        var response = StubResponse(error: NSError(domain: "com.sph.demo", code: 500, userInfo: [NSLocalizedDescriptionKey : Constants.serverError]))
        response.body = self.getJsonForStub(error: "ServerError")
        stub.response = response
        
        Hippolyte.shared.clearStubs()
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        Hippolyte.shared.stop()
    }
    
    func tesStubForInternalServerError() {
        
        let expectation = self.expectation(description: "Server Not Found")
        let usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: Constants.resourceId) { (isCache, status, message, usageResponse) in
            if(message == Constants.serverError){
            assert(message == Constants.serverError)
            assert(usageDetails.count == 0)
            Hippolyte.shared.stop()
            URLSession.shared.invalidateAndCancel()
            expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
}
