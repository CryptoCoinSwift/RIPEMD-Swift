//
//  RIPEMD+CircularShift.swift
//  RIPEMD
//
//  Created by Sjors Provoost on 08-07-14.
//

// Circular left shift: http://en.wikipedia.org/wiki/Circular_shift
// Precendence should be the same as <<
operator infix ~<< { precedence 160 associativity none }

func ~<< (lhs: UInt32, rhs: Int) -> UInt32 {
    return (lhs << UInt32(rhs)) | (lhs >> UInt32(32 - rhs));
}