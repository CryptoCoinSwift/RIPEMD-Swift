//
//  RIPEMD+Block.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

import Foundation

extension RIPEMD {
    struct Block {
        let message: [UInt32]
        
        init(_ message: [UInt32]) {
            assert(countElements(message) == 16, "Wrong message size")
            self.message = message
        }
        
        static func f (j: Int) -> ((UInt32, UInt32, UInt32) -> UInt32) {
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

        
        func r (j: Int, _  side: MessageIndex) -> UInt32 {
            return message[side[j]]
        }
        
        enum MessageIndex {
            case Left, Right
            
            subscript (j: Int) -> Int {
                switch j {
                case let index where j < 0:
                    assert("Invalid j")
                    return 0
                case let index where j <= 15:
                    if self == .Left {
                        return index
                    } else {
                        return [5,14,7,0,9,2,11,4,13,6,15,8,1,10,3,12][index]
                    }
                case let index where j <= 31:
                    if self == .Left {
                        return [7,4,13,1,10,6,15,3,12,0,9,5,2,14,11,8][index - 16]
                    } else {
                        return [11,3,7,0,13,5,10,14,15,8,12,4,9,1,2][index - 16]
                    }
                case let index where j <= 47:
                    if self == .Left {
                        return [3,10,14,4,9,15,8,1,2,7,0,6,13,11,5,12][index - 32]
                    } else {
                        return [15,5,1,3,7,14,6,9,11,8,12,2,10,0,4,13][index - 32]
                    }
                case let index where j <= 63:
                    if self == .Left {
                        return [1,9,11,10,0,8,12,4,13,3,7,15,14,5,6,2][index - 48]
                    } else {
                        return [8,6,4,1,3,11,15,0,5,12,2,13,9,7,10,14][index - 48]
                    }
                case let index where j <= 79:
                    if self == .Left {
                        return [ 4,0,5,9,7,12,2,10,14,1,3,8,11,6,15,13][index - 64]
                    } else {
                        return [12,15,10,4,1,5,8,7,6,2,13,14,0,3,9,11][index - 64]
                    }

                default:
                    assert("Invalid j")
                    return 0
                }
            }

            
        }
        
        enum s {
            case Left, Right
            
            subscript(j: Int) -> Int {
                switch index {
                case let index where j < 0:
                    assert("Invalid j")
                    return 0
                case let index where j <= 15:
                    return (self == .Left ? [11,14,15,12,5,8,7,9,11,13,14,15,6,7,9,8] : [8,9,9,11,13,15,15,5,7,7,8,11,14,14,12,6])[j]
                case let index where j <= 31:
                    return (self == .Left ? [7,6,8,13,11,9,7,15,7,12,15,9,11,7,13,12] : [9,13,15,7,12,8,9,11,7,7,12,7,6,15,13,11])[j - 16]
                case let index where j <= 47:
                    return (self == .Left ? [11,13,6,7,14,9,13,15,14,8,13,6,5,12,7,5] : [9,7,15,11,8,6,6,14,12,13,5,14,13,13,7,5])[j - 32]
                case let index where j <= 63:
                    return (self == .Left ? [11,12,14,15,14,15,9,8,9,14,5,6,8,6,5,12] : [15,5,8,11,14,14,6,14,6,9,12,9,12,5,15,8])[j - 48]
                case let index where j <= 79:
                    return (self == .Left ? [9,15,5,11,6,8,13,12,5,12,13,14,11,8,5,6] : [8,5,12,9,12,5,14,6,8,13,6,5,15,13,11,11])[j - 64]
                default:
                    assert("Invalid j")
                    return 0
                    }
            }

        }
        
        
        
    }
}