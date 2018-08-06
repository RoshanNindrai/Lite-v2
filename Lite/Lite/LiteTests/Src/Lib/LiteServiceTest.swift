//
//  LiteServiceTest.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 8/5/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Lite

class LiteServiceTest: PersistedServiceTest {

    var liteService: LiteServiceProvider<HttpBin, GetResponse>!

    override func setUp() {
        super.setUp()
        liteService = LiteServiceProvider<HttpBin, GetResponse>(NetworkServiceProvider(), configuration)
    }

    func testFromCache() {

        let liteExpectation = expectation(description: "We should get data from cache instead of hitting network")

        guard let realm = try? Realm() else {
            XCTAssertTrue(false)
            return
        }

        try? realm.write {
            realm.add(GetResponseRealm("https://httpbin.org/get"))
        }

        liteService.perform(.get) { response in
            print(response)
            liteExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

    }

    func testFromNetwork() {

        let liteExpectation = expectation(description: "We should get data from cache instead of hitting network")

        guard let realm = try? Realm() else {
            XCTAssertTrue(false)
            return
        }

        liteService.perform(.get) { [realm] response in
            print(response)
            //XCTAssertNotNil(realm.objects(GetResponseRealm.self).filter("url == %@", "https://httpbin.org/get"))
            liteExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

    }

}
