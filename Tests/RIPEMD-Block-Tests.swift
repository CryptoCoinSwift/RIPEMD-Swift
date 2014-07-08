//
//  RIPEMD_Block_Tests.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

import Cocoa
import XCTest
import RIPEMDmac

class RIPEMD_Block_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddedConstants() {
        let k40:UInt32 = 0x6ED9EBA1
        XCTAssertEqual(RIPEMD.Block.K.Left[40], k40, "");
    }
    
    func testBitlevelFunctions() {
        let x: UInt32 =       0b0000_0000_0000_1111
        let y: UInt32 =       0b1111_1111_1111_0000
        let z: UInt32 =       0b0000_1111_1111_0000
        
        let xORxOR: UInt32 =  0b1111_0000_0000_1111
        
        XCTAssertEqual(RIPEMD.Block.f()[12](x,y,z), xORxOR, "")
    }
    
}
