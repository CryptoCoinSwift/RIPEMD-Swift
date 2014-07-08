//
//  HexString.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

import Foundation

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