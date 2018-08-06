//
//  ServiceTests.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
@testable import Lite

class NetworkServiceTest: XCTestCase {

    let provider: NetworkServiceProvider<HttpBin, GetResponse> = NetworkServiceProvider<HttpBin, GetResponse>()

    func testGetDataOperation() {
        let getexpectation = expectation(description: "This is a test for get request")
        provider.perform(.get) { [ getexpectation ] response in
            switch response {
            case let .success(data):
                XCTAssertNotNil(data)
                getexpectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPostDataOperation() {
        let getexpectation = expectation(description: "This is a test for get request")
        provider.perform(.post(HTTPBinPost())) { [ getexpectation ] response in
            switch response {
            case let .success(data):
                XCTAssertNotNil(data)
                XCTAssertNotNil(data?.form)
                getexpectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDefaultPlugin() {
        let getexpectation = expectation(description: "This is a test for get request")
        Service.add(plugins: [MockPlugin()])
        provider.perform(.get) { [ getexpectation ] response in
            switch response {
            case let .success(data):
                XCTAssertNotNil(data)
                getexpectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
