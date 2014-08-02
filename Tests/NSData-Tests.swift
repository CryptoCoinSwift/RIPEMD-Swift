//
//  NSData-Tests.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 09-07-14.
//

#if os(OSX)
    import Cocoa
#endif

import XCTest

class NSDataTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHexString() {
        let hexString = "03" // Must be an even number
        let data = NSData.fromHexString(hexString)
        XCTAssertEqual(data.length, 1, "")
        XCTAssertEqual(data.toHexString(), "03", "")
    }

}
