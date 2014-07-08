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
        
    }
}