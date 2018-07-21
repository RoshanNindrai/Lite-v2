//
//  StringUtilsTests.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import XCTest
@testable import Lite

class StringUtilsTests: XCTestCase {

    func testExample() {
        let ready = "Ready"
        let executing = "Executing"
        let finished = "Finished"

        XCTAssertEqual("ready".firstUppercased, ready)
        XCTAssertEqual("executing".firstUppercased, executing)
        XCTAssertEqual("finished".firstUppercased, finished)
    }
}
