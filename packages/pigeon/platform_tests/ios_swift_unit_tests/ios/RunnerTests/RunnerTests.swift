//
//  RunnerTests.swift
//  RunnerTests
//
//  Created by Ailton Vieira on 28/02/22.
//  Copyright © 2022 The Flutter Authors. All rights reserved.
//

import XCTest
@testable import Runner

class RunnerTests: XCTestCase {
    
    func testToMapAndBack() throws {
        let reply = MGSearchReply(result: "foobar")
        let dict = reply.toMap()
        let copy = MGSearchReply.fromMap(dict)
        XCTAssertEqual(reply.result, copy?.result)
    }
    
    func testHandlesNull() throws {
        let reply = MGSearchReply()
        let dict = reply.toMap()
        let copy = MGSearchReply.fromMap(dict)
        XCTAssertNil(copy?.result)
    }
    
    func testHandlesNullFirst() throws {
        let reply = MGSearchReply(error: "foobar")
        let dict = reply.toMap()
        let copy = MGSearchReply.fromMap(dict)
        XCTAssertEqual(reply.error, copy?.error)
    }
}
