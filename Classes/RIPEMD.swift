//
//  RIPEMD.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

import Foundation

struct RIPEMD {
    static func digest (input : NSData, bitlength:Int = 160) -> NSData {
        assert(bitlength == 160, "Only RIPEMD-160 is implemented")
        // ...
        return NSData()
    }
    
    // Returns a string representation of a hexadecimal number
    static func hexStringDigest (input : NSData, bitlength:Int = 160) -> String {
        return HexString(digest(input, bitlength: bitlength)).string
    }
    
    // Takes a string representation of a hexadecimal number
    static func hexStringDigest (input : String, bitlength:Int = 160) -> NSData {
        let data = HexString(input).data
        return digest(data, bitlength: bitlength)
    }
    
    // Takes a string representation of a hexadecimal number and returns a
    // string represenation of the resulting 160 bit hash.
    static func hexStringDigest (input : String, bitlength:Int = 160) -> String {
        let digest: NSData = hexStringDigest(input, bitlength: bitlength)
        return HexString(digest).string
    }
    
    // Takes an ASCII string
    static func asciiDigest (input : String, bitlength:Int = 160) -> NSData {
        // TODO: convert ASCII string to bytes
        let data = NSData()
        return digest(data, bitlength: bitlength)
    }
    
    // Takes an ASCII string and returns a string represenation of the 
    // resulting 160 bit hash.
    static func asciiDigest (input : String, bitlength:Int = 160) -> String {
        let digest: NSData = asciiDigest(input, bitlength: bitlength)
        // TODO: convert bytes to ASCII string
        return ""
    }

    
}