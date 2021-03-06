//
//  LiteServiceTest.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 8/5/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
import PromiseKit
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
            realm.add(GetResponseEntity("https://httpbin.org/get"))
        }

        liteService.perform(.get) { response in
            print(response)
            liteExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

    }

    func testRequestChaining() {

        let litePromiseExpectation = expectation(description: "Promise")
        firstly {
            liteService.perform(.get)
        }.then { [unowned self] result -> Promise<GetResponse?> in
            litePromiseExpectation.fulfill()
            return self.liteService.perform(.get)
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFromNetwork() {

        let liteExpectation = expectation(description: "We should get data from cache instead of hitting network")

        guard let realm = try? Realm() else {
            XCTAssertTrue(false)
            return
        }

        XCTAssertNil(realm.objects(GetResponseEntity.self).filter(HttpBin.get.predicate).first)
        // from server
        liteService.perform(.get) { [realm] response in
            // from memory
            self.liteService.perform(.get) { [realm] response in
                DispatchQueue.main.async {
                    XCTAssertNotNil(realm.objects(GetResponseEntity.self).filter(HttpBin.get.predicate).first)
                    liteExpectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)

    }

}
