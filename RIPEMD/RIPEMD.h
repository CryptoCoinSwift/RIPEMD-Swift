//
//  RIPEMD.h
//  RIPEMD
//
//  Created by Sjors Provoost on 03-08-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

#ifdef __APPLE__
#include "TargetConditionals.h"

#if TARGET_IPHONE_SIMULATOR
#define iOs

#elif TARGET_OS_IPHONE
#define iOs

#elif TARGET_OS_MAC
// mac os

#else
// Unsupported platform
#endif
#endif

#ifdef iOs
#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double RIPEMDVersionNumber;

FOUNDATION_EXPORT const unsigned char RIPEMDVersionString[];
#else
#import <Cocoa/Cocoa.h>

//! Project version number for UInt256Mac.
FOUNDATION_EXPORT double RIPEMDMacVersionNumber;

//! Project version string for UInt256Mac.
FOUNDATION_EXPORT const unsigned char RIPEMDMacVersionString[];
#endif