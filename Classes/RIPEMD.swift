//
//  RIPEMD.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

import Foundation

public struct RIPEMD {
    public static func digest (input : NSData, bitlength:Int = 160) -> NSData {
        assert(bitlength == 160, "Only RIPEMD-160 is implemented")
        
        let paddedData = pad(input)
        
        var block = RIPEMD.Block()
        
        for var i=0; i < paddedData.length / 64; i++ {
            let part = getWordsInSection(paddedData, i)
            block.compress(part)
        }

        return encodeWords(block.hash)
    }
    
    // Pads the input to a multiple 64 bytes. First it adds 0x80 followed by zeros.
    // It then needs 8 bytes at the end where it writes the length (in bits, little endian).
    // If this doesn't fit it will add another block of 64 bytes.
    
    // FIXME: Make private once tests support it
    public static func pad(data: NSData) -> NSData {
        var paddedData = data.mutableCopy() as! NSMutableData
        
        // Put 0x80 after the last character:
        let stop: [UInt8] = [UInt8(0x80)] // 2^8
        paddedData.appendBytes(stop, length: 1)
        
        // Pad with zeros until there are 64 * k - 8 bytes.
        var numberOfZerosToPad: Int;
        if paddedData.length % 64 == 56 {
            // No padding needed
            numberOfZerosToPad = 0
        } else if paddedData.length % 64 < 56 {
            numberOfZerosToPad = 56 - (paddedData.length % 64)
        } else {
            // Add an extra round
            numberOfZerosToPad = 56 + (64 - paddedData.length % 64)
        }
        
        let zeroBytes = [UInt8](count: numberOfZerosToPad, repeatedValue: 0)
        paddedData.appendBytes(zeroBytes, length: numberOfZerosToPad)
        
        // Append length of message:
        let length: UInt32 = UInt32(data.length) * 8
        let lengthBytes: [UInt32] = [length, UInt32(0x00_00_00_00)]
        paddedData.appendBytes(lengthBytes, length: 8)
        
        return paddedData as NSData
    }
    
    // Takes an NSData object of length k * 64 bytes and returns an array of UInt32 
    // representing 1 word (4 bytes) each. Each word is in little endian,
    // so "abcdefgh" is now "dcbahgfe".
    // FIXME: Make private once tests support it
    public static func getWordsInSection(data: NSData, _ section: Int) -> [UInt32] {
        let offset = section * 64
        
        assert(data.length >= Int(offset + 64), "Data too short")
        
         var words: [UInt32] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
         data.getBytes(&words, range: NSMakeRange(offset, 64))

        
        return words
    }
    
    // FIXME: Make private once tests support it
    public static func encodeWords(input: [UInt32]) -> NSData {
        let data = NSMutableData(bytes: input, length: 20)
        return data
    }
    
    // Returns a string representation of a hexadecimal number
    public static func digest (input : NSData, bitlength:Int = 160) -> String {
        return digest(input, bitlength: bitlength).toHexString()
    }
    
    // Takes a string representation of a hexadecimal number
    public static func hexStringDigest (input : String, bitlength:Int = 160) -> NSData {
        let data = NSData.fromHexString(input)
        return digest(data, bitlength: bitlength)
    }
    
    // Takes a string representation of a hexadecimal number and returns a
    // string represenation of the resulting 160 bit hash.
    public static func hexStringDigest (input : String, bitlength:Int = 160) -> String {
        let digest: NSData = hexStringDigest(input, bitlength: bitlength)
        return digest.toHexString()
    }
    
    // Takes an ASCII string
    public static func asciiDigest (input : String, bitlength:Int = 160) -> NSData {
        // Order of bytes is preserved; if the last character is dot, the last 
        // byte is a dot.
        if let data: NSData = input.dataUsingEncoding(NSASCIIStringEncoding) {
            return digest(data, bitlength: bitlength)
        } else {
            assert(false, "Invalid input")
            return NSData()
        }
    }
    
//     Takes an ASCII string and returns a hex string represenation of the
//     resulting 160 bit hash.
    public static func asciiDigest (input : String, bitlength:Int = 160) -> String {
        return asciiDigest(input, bitlength: bitlength).toHexString()
    }
    
}