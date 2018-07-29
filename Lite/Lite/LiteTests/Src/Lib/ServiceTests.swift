//
//  ServiceTests.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
@testable import Lite

/*
 
 "args": {},
 "headers": {
 "Accept": "",
"Accept-Encoding": "gzip, deflate",
"Cache-Control": "no-cache",
"Connection": "close",
"Host": "httpbin.org",
"Postman-Token": "0fdfb915-2a4a-4580-98eb-9f237a98bcda",
"User-Agent": "PostmanRuntime/7.1.1"
},
"origin": "108.69.132.164",
"url": "https://httpbin.org/get"
 
 */
struct GetResponse: Codable {
    let args: [String: String]
    let headers: [String: String]
    let origin: String
    let form: [String: String]?
    let url: URL
}

class ServiceTests: XCTestCase {

    let provider: ServiceProvider<HttpBin, GetResponse> = ServiceProvider<HttpBin, GetResponse>()

    func testGetDataOperation() {
        let getexpectation = expectation(description: "This is a test for get request")
        provider.perform(.get) { [ getexpectation ] response in
            switch response {
            case let .success(data, _):
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
            case let .success(data, _):
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
            case let .success(data, _):
                XCTAssertNotNil(data)
                getexpectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
