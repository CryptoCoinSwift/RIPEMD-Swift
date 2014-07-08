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
        let message: [UInt32]
        
        init(_ message: [UInt32]) {
            assert(countElements(message) == 16, "Wrong message size")
            self.message = message
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
        
        
    }
}