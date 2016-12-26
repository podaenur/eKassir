//
//  GatewayTests.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 19/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import XCTest

class GatewayTests: XCTestCase {
    
    let gateway = APIGateway.sharedInstance
    
    func testFetchData() {
        let expect = expectation(description: "Data fetching")
        
        gateway.fetchData() { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            let _response = response as! HTTPURLResponse
            XCTAssertEqual(_response.statusCode, 200)
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 60)
    }
    
    func testFetchIcon() {
        let expect = expectation(description: "Icon 01.jpg fetching")
        
        gateway.fetchCarIcon(name: "01.jpg") { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
//            let _response = response as! HTTPURLResponse
//            XCTAssertEqual(_response.statusCode, 200)
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 60)
    }
}
