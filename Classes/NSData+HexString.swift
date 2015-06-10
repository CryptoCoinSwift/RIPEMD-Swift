//
//  HexString.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

import Foundation

extension NSData {
    public func toHexString () -> String {
        var hexString = NSMutableString()
        
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        for byte in bytes {
            hexString.appendFormat("%02hhx", byte)
        }
        
        return hexString.copy() as! String
    }

    public class func fromHexString (string: String) -> NSData {
        // Based on: http://stackoverflow.com/a/2505561/313633
        var data = NSMutableData()
            
        var temp = ""
        
        for char in string {
            temp+=String(char)
            if(count(temp) == 2) {
                let scanner = NSScanner(string: temp)
                var value: CUnsignedInt = 0
                scanner.scanHexInt(&value)
                data.appendBytes(&value, length: 1)
                temp = ""
            }
            
        }
        
        return data as NSData
    }
}
