//
//  RIPEMD_Block_Tests.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

#if os(OSX)
import Cocoa
#endif

import XCTest
import RIPEMD

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
        
        let function = RIPEMD.Block().f(12)
        let result = function(x,y,z)
        
        XCTAssertEqual(result, xORxOR, "")
    }
    
    func testWordSelection() {
        let message: [UInt32] = [0,0,0,0,1,0,0,0,0,0,0,0,0,0,2,0]
        
        let r17l = message[RIPEMD.Block.r.Left[17]]
        let r63r = message[RIPEMD.Block.r.Right[63]]

        
        XCTAssertEqual(r63r, 2, "")

    }
    
    func testRotationAmount() {
        let s17r = RIPEMD.Block.s.Right[17]
        let expected: Int = 13
        
        XCTAssertEqual(s17r, expected, "")
    }
    
    func testZero() {
        // One of the test vectors  is an empty string. Should result in the same hash as 1 iteration.
        
        /* Padding rules according to: https://github.com/agoebel/RIPEMD-160
        Start with 0x80 followed by zeros, followed by the 64-bit length of the string in BITS (bits = 8 times number of bytes) in little-endian form. */
        
        let message: [UInt32] = [UInt32(bigEndian: 0x80_00_00_00),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                                                // 0x80 is in little endian
        
        var digester = RIPEMD.Block()
        digester.compress(message)
        
        let h0: UInt32 = digester.hash[0]
        let h1: UInt32 = digester.hash[1]
        let h2: UInt32 = digester.hash[2]
        let h3: UInt32 = digester.hash[3]
        let h4: UInt32 = digester.hash[4]
        
        // "" -> 9c1185a5 c5e9fc54 61280897 7ee8f548 b2258d31
        
        let check0: Bool = h0 == UInt32(bigEndian: 0x9c1185a5) // 0x9c1185a5 is in little endian
        let check1: Bool = h1 == UInt32(bigEndian: 0xc5e9fc54)
        let check2: Bool = h2 == UInt32(bigEndian: 0x61280897)
        let check3: Bool = h3 == UInt32(bigEndian: 0x7ee8f548)
        let check4: Bool = h4 == UInt32(bigEndian: 0xb2258d31)
        
        
        // Test will crash if you use more than two XTAssertTrue statements.
        // Either that or it had something to do with UInt32 values larger than 2^31
        
        XCTAssertTrue(check0 && check1 && check2 && check3 && check4, "")

    }
    
    func testA() {
        // "a" is another test vector. This allows to test thorny issues like padding rules,
        // conversion from ASCII to bytes and endianess.
        
        let a: UInt32 = UInt32(bigEndian: 0x61_00_00_00)
        

        
        // Message gets padded with 0x80 and zeros. The last 8 bytes
        // store, in little endian, the length of the message in bits.
        
        let message: [UInt32] = [UInt32(bigEndian: 0x61_80_00_00),0,0,0,0,0,0,0,0,0,0,0,0,0,8,0]
        
        let aString = NSString(format: "0x%2x", UInt32(bigEndian: 0x61_80_00_00))
        println(aString)
        
        var digester = RIPEMD.Block()
        digester.compress(message)
        
        let h0: UInt32 = digester.hash[0]
        let h1: UInt32 = digester.hash[1]
        let h2: UInt32 = digester.hash[2]
        let h3: UInt32 = digester.hash[3]
        let h4: UInt32 = digester.hash[4]
        
        // "a" -> 0bdc9d2d 256b3ee9 daae347b e6f4dc83 5a467ffe
        
        let check0: Bool = h0 == UInt32(bigEndian: 0x0bdc9d2d)
        let check1: Bool = h1 == UInt32(bigEndian: 0x256b3ee9)
        let check2: Bool = h2 == UInt32(bigEndian: 0xdaae347b)
        let check3: Bool = h3 == UInt32(bigEndian: 0xe6f4dc83)
        let check4: Bool = h4 == UInt32(bigEndian: 0x5a467ffe)
        
        XCTAssertTrue(check0 && check1 && check2 && check3 && check4, "")

    }
    
    func testRosettaCode() {
        //
        var block = RIPEMD.Block()
        let message:[UInt32] = [ 0x65_73_6f_52, 0x20_61_74_74, 0x65_64_6f_43, 0x00_00_00_80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0 ]
        block.compress(message)
        
        let digest = NSString(format: "%2x%2x%2x%2x%2x", UInt32(bigEndian: block.hash[0]), UInt32(bigEndian: block.hash[1]),UInt32(bigEndian: block.hash[2]), UInt32(bigEndian: block.hash[3]), UInt32(bigEndian: block.hash[4]))
        
        XCTAssertEqual(digest, "b3be159860842cebaa7174c8fff0aa9e50a5199f", "")
    }

}
