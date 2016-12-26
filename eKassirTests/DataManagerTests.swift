//
//  DataManagerTests.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 21/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import XCTest

class DataManagerTests: XCTestCase {
    
    var dataManager: DataManager!
    var imageNmae: String!
    
    override func setUp() {
        
        /// Switch mock/real dataManager should be tested
        let isMocked = false
        
        switch isMocked {
        case true:
            dataManager = MockDataManager()
            imageNmae = "no matter what name use here"
        case false:
            dataManager = DataManager()
            imageNmae = "01.jpg"
        }
    }
    
    func testFetchOrders() {
        let expect = expectation(description: "Data manager orders fetching")
        dataManager.fetchOrders { (result) in
            switch result {
            case let .success(object):
                XCTAssertNotNil(object)
                guard let allObjects = object as? [OrderEntity] else {
                    XCTFail()
                    expect.fulfill()
                    return
                }
                XCTAssertTrue(allObjects.count > 0)
            case .failure(_):
                XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 60)
    }
    
    func testFetchCarImage() {
        let expect = expectation(description: "Data manager car image fetching")
        dataManager.fetchCarImage(name: imageNmae) { (result) in
            switch result {
            case let .success(object):
                XCTAssertNotNil(object)
                guard let image = object as? UIImage else {
                    XCTFail()
                    expect.fulfill()
                    return
                }
                XCTAssertNotNil(image)
            case .failure(_):
                XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 60)
    }
}
