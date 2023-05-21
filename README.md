# DataConvertible

## Purpose

Convert any Swift type to Data and initialize any Swift type from Data.

## Usage

```swift
// T can be Data, String, Int, Int8, Int16, Int32, Int64, Float, Double, Date, Array, Set, Dictionary
let x: T

// Return the content of x as Data
x.binaryData

// Initialize an instance of type T from the content of a Data value
let y = T(binaryData: d) 
```

Author: Raphaël Wach
