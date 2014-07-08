//
//  RIPEMDmacTests.swift
//  RIPEMDmacTests
//
//  Created by Sjors Provoost on 08-07-14.
//

import XCTest
import RIPEMDmac

class RIPENDmacTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test vectors from http://homes.esat.kuleuven.be/~bosselae/ripemd160.html
    
    func testEmptyString() {
        let message = ""
        let hash = "9c1185a5c5e9fc54612808977ee8f548b2258d31"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testA() {
        let message = "a"
        let hash = "0bdc9d2d256b3ee9daae347be6f4dc835a467ffe"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testABC() {
        let message = "abc"
        let hash = "8eb208f7e05d987a9b044a8e98c6b087f15a0bfc"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testMessageDigest() {
        let message = "message digest"
        let hash = "5d0689ef49d2fae572b881b123a85ffa21595f36"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testAlphabet() {
        let message = "abcdefghijklmnopqrstuvwxyz"
        let hash = "f71c27109c692c1b56bbdceb5b9d2865b3708dbc"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testAlphabetSoup() {
        let message = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
        let hash = "12a053384a9c0c88e405a06c27dcf49ada62eb2b"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testAplhabetUpcaseDowncaseNumbers() {
        let message = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let hash = "b0e20b6e3116640286ed3a87a5713079b21f5189"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testManyNumbers() {
        let numbers = "1234567890"
        var message = ""
        for _ in 1...8 {
            message += numbers
        }
        
        let hash = "9b752e45573d4b39f4dbd3323cab82bf63326bfb"
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    func testMilionTimesA() {
        let a = Character("a")
        let message = String(count: 1_000_000, repeatedValue: a)
        
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    // Hex string example from https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses
    
    func testHexString() {
        let message = "600ffe422b4e00731a59557a5cca46cc183944191006324a447bdb2d98d4b408" // 256 bit integer
        let hash = "010966776006953d5567439e5e39f86a0d273bee"
        
        XCTAssertEqual(RIPEMD.hexStringDigest(message), hash, "")

    }
    
    
}
