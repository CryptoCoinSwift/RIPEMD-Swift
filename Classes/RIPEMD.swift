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
        
        if input.length == 55 {
            let paddedData = pad(input)
            
            var block = RIPEMD.Block()
            
            let part1 = getWordsInSection(paddedData, 0)

            block.compress(part1)
            
            return encodeWords(block.hash)
            
        } else {
            return NSData()

        }
        
    }
    
    // Pads the input to a multiple 64 bytes. First it adds 0x80 followed by zeros.
    // It then needs 8 bytes at the end where it writes the length (in bits, little endian).
    // If this doesn't fit it will add another block of 64 bytes.
    static func pad(data: NSData) -> NSData {
        var paddedData = data.mutableCopy() as NSMutableData
        
        let stop: [UInt8] = [UInt8(0x80)] // 2^8
        paddedData.appendBytes(stop, length: 1)
        
        let length: UInt32 = UInt32(data.length) * 8
        let lengthBytes: [UInt32] = [length, UInt32(0x00_00_00_00)]
        paddedData.appendBytes(lengthBytes, length: 8)
        
        return paddedData as NSData
    }
    
    // Takes an NSData object of length k * 64 bytes and returns an array of UInt32 
    // representing 1 word (4 bytes) each. Each word is in little endian,
    // so "abcdefgh" is now "dcbahgfe".
    
    static func getWordsInSection(data: NSData, _ section: Int) -> [UInt32] {
        let offset = section * 64
        
        assert(data.length >= Int(offset + 64), "Data too short")
        
         var words: [UInt32] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
         data.getBytes(&words, range: NSMakeRange(offset, 64))

        
        return words
    }
    
    static func encodeWords(input: [UInt32]) -> NSData {
        let data = NSMutableData(bytes: input, length: 20)
        return data
    }
    
    // Returns a string representation of a hexadecimal number
    static func hexStringDigest (input : NSData, bitlength:Int = 160) -> String {
        return digest(input, bitlength: bitlength).toHexString()
    }
    
    // Takes a string representation of a hexadecimal number
    static func hexStringDigest (input : String, bitlength:Int = 160) -> NSData {
        let data = NSData.fromHexString(input)
        return digest(data, bitlength: bitlength)
    }
    
    // Takes a string representation of a hexadecimal number and returns a
    // string represenation of the resulting 160 bit hash.
    static func hexStringDigest (input : String, bitlength:Int = 160) -> String {
        let digest: NSData = hexStringDigest(input, bitlength: bitlength)
        return digest.toHexString()
    }
    
    // Takes an ASCII string
    static func asciiDigest (input : String, bitlength:Int = 160) -> NSData {
        // Order of bytes is preserved; if the last character is dot, the last 
        // byte is a dot.
        if let data: NSData = input.dataUsingEncoding(NSASCIIStringEncoding) {
            return digest(data, bitlength: bitlength)
        } else {
            assert("Invalid input")
            return NSData()
        }
    }
    
    // Takes an ASCII string and returns a hex string represenation of the
    // resulting 160 bit hash.
    static func asciiDigest (input : String, bitlength:Int = 160) -> String {
        return asciiDigest(input, bitlength: bitlength).toHexString()
    }
    
}