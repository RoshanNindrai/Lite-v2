//
//  PersistedServiceTest.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
import Realm
import RealmSwift
@testable import Lite

class PersistedServiceTest: XCTestCase {

    let configuration = RLMRealmConfiguration.default()
    var provider: PersistedServiceProvider<HttpBin, GetResponse>!

    override func setUp() {
        super.setUp()
        configuration.inMemoryIdentifier = "com.uniqlabs.lite.unittests"
        provider = PersistedServiceProvider<HttpBin, GetResponse>(configuration: configuration)

    }
}

class PersistedServiceDataTest: PersistedServiceTest {
    func testNoData() {
        let getNoDataExpectation = expectation(description: "Called with respononse containing error for no data")
        provider.perform(.get) { response in
            XCTAssertNotNil(response)
            print(response)
            getNoDataExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testWithDummyData() {

        guard let realm = try? Realm() else {
            XCTAssertTrue(false)
            return
        }

        try? realm.write {
            realm.add(GetResponseEntity("https://httpbin.org/get"))
        }

        let getNoDataExpectation = expectation(description: "Called with response containing error for no data")
        provider.perform(.get) { response in
            if case let Response.success(data) = response {
                XCTAssertNotNil(data)
                getNoDataExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
