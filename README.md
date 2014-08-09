RIPEMD-Swift
============
Native Swift implementation of the [RIPEMD](http://homes.esat.kuleuven.be/~bosselae/ripemd160.html) hash function.

Usage
-----
Checkout the [playground](RIPEMD-160.playground/section-1.swift).

To digest an ASCII string:

```swift
let message         = "Lorem ipsum dolor sit amet"
let digest: String  = RIPEMD.asciiDigest(message)
-> "7d0982be59ebe828d02aa0d031aa6651644d60da"
```
  
To digest a string representing a hexadecimal number (e.g. a BigInt):

```swift
let message         = "600ffe422b4e00731a59557a5cca46cc183944191006324a447bdb2d98d4b408"
let digest: String  = RIPEMD.hexStringDigest(message) 
-> "010966776006953d5567439e5e39f86a0d273bee"
```

To digest bytes stored in NSData:

```swift
let data: NSData    = ...
let digest: String  = RIPEMD.digest(data) 
```

It can return an NSData object:

```swift
let digest: NSData  = RIPEMD.asciiDigest(message)
```