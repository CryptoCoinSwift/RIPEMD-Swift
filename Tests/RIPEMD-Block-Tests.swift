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
        
        let function = RIPEMD.Block.f(12)
        let result = function(x,y,z)
        
        XCTAssertEqual(result, xORxOR, "")
    }
    
    func testWordSelection() {
        let message: [UInt32] = [0,0,0,0,1,0,0,0,0,0,0,0,0,0,2,0]
        
        let r17l = RIPEMD.Block(message).r(17, .Left)
        let r63r = RIPEMD.Block(message).r(63, .Right)

        
        XCTAssertEqual(r63r, 2, "")

    }
    
    func testRotationAmount() {
        let s17r = RIPEMD.Block.s.Right[17]
        
        XCTAssertEqual(s17r, 13, "")
    }
    
}
