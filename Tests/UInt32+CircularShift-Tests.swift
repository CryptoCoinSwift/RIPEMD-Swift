//
//  RIPEMD Bitwise Tests.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

import XCTest
import RIPEMD

class RIPEMD_Bitwise_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCyclicLeftShift() {
        let a:    UInt32 = 0b00111000001001101011100000010110
        let σ₁a:  UInt32 = 0b01110000010011010111000000101100
        let σ₁₀a: UInt32 = 0b10011010111000000101100011100000
        
        XCTAssertEqual(a ~<<  1, σ₁a,  "")
        XCTAssertEqual(a ~<< 10, σ₁₀a, "")
    }
}
