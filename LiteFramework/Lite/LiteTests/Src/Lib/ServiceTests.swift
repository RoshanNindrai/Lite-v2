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
    let form: [String: String]
    let url: URL
}

class ServiceTests: XCTestCase {

    func testGetDataOperation() {
        let getexpectation = expectation(description: "This is a test for get request")
        let request = Request<GetResponse>(url: URL(string: "https://httpbin.org/get")!, method: .get,
                                      type: RequestType.data).onSuccess { [ getexpectation ] (data, response) in
                XCTAssertNotNil(data)
                XCTAssertEqual(data?.url, URL(string: "https://httpbin.org/get")!)
                XCTAssertNotNil(response)
                getexpectation.fulfill()
        }.onFailure { (error) in
                XCTAssertNotNil(error)
        }

        Service.perform(request)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPostDataOperation() {
        let getexpectation = expectation(description: "This is a test for get request")
        let request = Request<GetResponse>(url: URL(string: "https://httpbin.org/post")!,
                                           method: .post(["data": "me"]),
                                           type: RequestType.data).onSuccess { [ getexpectation ] (data, response) in
                                            XCTAssertNotNil(data)
                                            XCTAssertNotNil(data?.form)
                                            XCTAssertEqual(data?.url, URL(string: "https://httpbin.org/post")!)
                                            XCTAssertNotNil(response)
                                            getexpectation.fulfill()
            }.onFailure { (error) in
                XCTAssertNotNil(error)
        }

        Service.perform(request)
        waitForExpectations(timeout: 10, handler: nil)
    }

}
