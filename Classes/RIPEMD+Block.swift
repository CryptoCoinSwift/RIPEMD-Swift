//
//  RIPEMD+Block.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

import Foundation

extension RIPEMD {
    struct Block {
        struct f {
            
            // Unfortunately static subscript is not allowed
            subscript(j: Int) -> ((UInt32, UInt32, UInt32) -> UInt32) {
                switch j {
                case let index where j < 0:
                    assert("Invalid j")
                    return {(_, _, _) in 0 }
                case let index where j <= 15:
                    return {(x, y, z) in  x ^ y ^ z }
                case let index where j <= 31:
                    return {(x, y, z) in  (x & y) | (~x & z) }
                case let index where j <= 47:
                    return {(x, y, z) in  (x | ~y) ^ z }
                case let index where j <= 63:
                    return {(x, y, z) in  (x & z) | (y & ~z) }
                case let index where j <= 79:
                    return {(x, y, z) in  x | (y | ~z) }
                default:
                    assert("Invalid j")
                    return {(_, _, _) in 0 }
                    }
                    
                    
            }
        }

        
        enum K {
            case Left, Right
        
            subscript(j: Int) -> UInt32 {
                switch index {
                case let index where j < 0:
                    assert("Invalid j")
                    return 0
                case let index where j <= 15:
                    return self == .Left ? 0x00000000 : 0x50A28BE6
                case let index where j <= 31:
                    return self == .Left ? 0x5A827999 : 0x5C4DD124
                case let index where j <= 47:
                    return self == .Left ? 0x6ED9EBA1 : 0x6D703EF3
                case let index where j <= 63:
                    return self == .Left ? 0x8F1BBCDC : 0x7A6D76E9
                case let index where j <= 79:
                    return self == .Left ? 0xA953FD4E : 0x00000000
                default:
                    assert("Invalid j")
                    return 0
                }
            }
        }
    }
}