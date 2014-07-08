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

struct HexString {
    let string: String
    
    init(_ string:String) {
        // TODO: check for invalid characters
        self.string = string
    }
    
    init(_ data: NSData) {
        let sha256description = data.description as String
        
        // TODO: more elegant way to convert NSData to a hex string
        
        var result: String = ""
        
        for char in sha256description {
            switch char {
            case "0", "1", "2", "3", "4", "5", "6", "7","8","9", "a", "b", "c", "d", "e", "f":
                result += char
            default:
                result += ""
            }
        }
        
        self.string = result
    }

    var data: NSData {
        // Based on: http://stackoverflow.com/a/2505561/313633
        var data = NSMutableData()
        
        var string = ""
        
        for char in string {
            string+=char
            if(countElements(string) == 2) {
                let scanner = NSScanner(string: string)
                var value: CUnsignedInt = 0
                scanner.scanHexInt(&value)
                data.appendBytes(&value, length: 1)
                string = ""
            }
            
        }
        
        return data as NSData
    }

}