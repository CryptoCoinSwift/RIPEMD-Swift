// To use this Playground select RIPEMD-Mac as the scheme and build.

import RIPEMD

// To digest an ASCII string
var message         = "Lorem ipsum dolor sit amet"
var digest: String  = RIPEMD.asciiDigest(message)

// To digest a string representing a hexadecimal number:
message         = "600ffe422b4e00731a59557a5cca46cc183944191006324a447bdb2d98d4b408"
digest = RIPEMD.hexStringDigest(message)

// To digest bytes stored in NSData:
let data = NSData.fromHexString(message)
digest = RIPEMD.digest(data)

// It can also return an NSData object:
let digestData: NSData  = RIPEMD.digest(data)
digestData.toHexString()