//
//  RIPEMDmacTests.swift
//  RIPEMDmacTests
//
//  Created by Sjors Provoost on 08-07-14.
//

import XCTest
import RIPEMD

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
    
    // Test passes but takes 30 seconds in Release configuration
//    func testMilionTimesA() {
//        let a = Character("a")
//        let message = String(count: 1_000_000, repeatedValue: a)
//        let hash = "52783243c1697bdbe16d37f97f68f08325dc1528"
//        
//        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
//    }
    
    // Hex string example from https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses
    
    func testHexString() {
        let message = "600ffe422b4e00731a59557a5cca46cc183944191006324a447bdb2d98d4b408" // 256 bit integer
        let hash = "010966776006953d5567439e5e39f86a0d273bee"
        
        XCTAssertEqual(RIPEMD.hexStringDigest(message), hash, "")

    }
    
    // Some other vectors
    
    func testSingleBlockMessage() {
        // 55 characters = 1 block without zero padding (see test55charactersNotPadded)
        let message = "Sed ut perspiciatis unde omnis iste natus error sit vol"
        let hash    = "e6f95b697f98c944e6234a6313e11e179c8e867c"
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    
    func testQuadBlockMessage() {
        // 256 - 9 = 247
        
        let message = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia"
       
        let hash    = "5f5b48448f5e0abab49da46b9c8c0b0395eac519"
        XCTAssertEqual(RIPEMD.asciiDigest(message), hash, "")
    }
    
    // RIPEMD blocks
    
    func testGetWordsInSection() {
        let message = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa."
        
        if let data: NSData = message.dataUsingEncoding(NSASCIIStringEncoding) {
            let expected: Int = 128
            XCTAssertEqual(data.length, expected)
            
            let section  = RIPEMD.getWordsInSection(data, 1)
            
            let psaDot:    UInt32 = UInt32(bigEndian: 0x70_73_61_2e) // "psa."
            let section15: UInt32 = section[15]
            
            let section15s = NSString(format: "%2x",section15)
            
            XCTAssertEqual(section15, psaDot, "'psa.' not found in 2nd section: \( section15s )")
        }

    }
    
    func testEncodeWords() {
        // Message: "Sed ut perspiciatis unde omnis iste natus error sit vol"
        // Hash:    "e6f95b697f98c944e6234a6313e11e179c8e867c"
        let hashWords: [UInt32] = [UInt32(bigEndian:0xe6f95b69),UInt32(bigEndian:0x7f98c944),UInt32(bigEndian:0xe6234a63),UInt32(bigEndian:0x13e11e17),UInt32(bigEndian:0x9c8e867c)]
        
        let hash = RIPEMD.encodeWords(hashWords)
        
        let hashHexString = hash.toHexString()
        let expected: String = "e6f95b697f98c944e6234a6313e11e179c8e867c"
        
        XCTAssertEqual(hashHexString, expected, "")
        
    }
    
    func test55charactersNotPadded() {
        /* Multiples of 64 characters minus 9 don't need padding. The 9th last byte is used to write 0x80. The last 8 bytes store the length. A string of 55 characters should only be appended with 0x80 and the two length bytes making it 64 bytes long. */
        
        let message = "Sed ut perspiciatis unde omnis iste natus error sit vol"
        
        if let data: NSData = message.dataUsingEncoding(NSASCIIStringEncoding) {
            var expected: Int = 55
            XCTAssertEqual(data.length, expected)
            
            var paddedData = data.mutableCopy() as! NSMutableData
            
            let stop: [UInt8] = [UInt8(0x80)] // 2^8
            paddedData.appendBytes(stop, length: 1)
            
            let lengthBytes: [UInt32] = [55 * 8, 0]
            paddedData.appendBytes(lengthBytes, length: 8)
            
            expected = 64

            XCTAssertEqual(paddedData.length, expected)
            
            
            var byte: UInt8 = 0x00
            
            let result = RIPEMD.pad(data)
            
            XCTAssertEqual(result.length, expected)
            
            
            result.getBytes(&byte, range: NSMakeRange(15, 1))
            XCTAssertEqual(byte, UInt8(0x61), "16th character is not 'a'")
            
            result.getBytes(&byte, range: NSMakeRange(54, 1))
            XCTAssertEqual(byte, UInt8(0x6C), "55th character is not 'l'")
            
            XCTAssertEqual(result, paddedData, "")
            
        } else {
            XCTAssertTrue(false, "Message encoding failed")
        }
    }

}