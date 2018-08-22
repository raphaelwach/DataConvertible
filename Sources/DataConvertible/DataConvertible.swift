//
//  DataConvertible.swift
//
//  Created by Raphaël Wach on 21/08/2018.
//
/******************************************************************************
MIT License

Copyright (c) 2018 Raphaël Wach

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************************/


import Foundation

protocol DataConvertible {
	var binaryData: Data { get }
	init?(binaryData: Data)
}

// MARK: - Data

extension Data: DataConvertible {
	
	var binaryData: Data {
		return self
	}
	
	init?(binaryData: Data) {
		self = binaryData
	}
	
}

// MARK: - String

extension String: DataConvertible {
	
	var binaryData: Data {
		if self.isEmpty {
			return "\0".data(using: .utf8)!
		}
		return self.data(using: .utf8)!
	}
	
	init?(binaryData: Data) {
		guard let str = String(data: binaryData, encoding: .utf8) else {
			return nil
		}
		self = str.trimmingCharacters(in: CharacterSet(charactersIn:"\0"))
	}
	
}

// MARK: - Numbers

protocol NumberDataConvertible: DataConvertible, Equatable {
	
}

extension NumberDataConvertible {
	
	public var binaryData: Data {
		var i = self
		return Data(bytes: &i, count: MemoryLayout<Self>.size)
	}
	
	public init?(binaryData: Data) {
		if binaryData.count != MemoryLayout<Self>.size {
			return nil
		}
		self = binaryData.withUnsafeBytes { $0.pointee }
	}

}

// MARK: - Int

extension Int: NumberDataConvertible {

}

extension Int8: NumberDataConvertible {
	
}

extension Int16: NumberDataConvertible {
	
}

extension Int32: NumberDataConvertible {
	
}

extension Int64: NumberDataConvertible {
	
}

// MARK: - Float

extension Float: NumberDataConvertible {
	
}

// MARK: - Double

extension Double: NumberDataConvertible {
	
}

// MARK: - Bool

extension Bool: NumberDataConvertible {
	
}

// MARK: - Date

extension Date: DataConvertible {
	
	public var binaryData: Data {
		return self.timeIntervalSince1970.binaryData
	}
	
	public init?(binaryData: Data) {
		guard let timestamp = Double(binaryData: binaryData) else {
			return nil
		}
		self = Date(timeIntervalSince1970: timestamp)
	}
	
}


// MARK: - Collections

protocol CollectionDataConvertible: DataConvertible {
	
}

extension CollectionDataConvertible {
	
	public var binaryData: Data {
		return NSKeyedArchiver.archivedData(withRootObject: self)
	}
	
	public init?(binaryData: Data) {
		self = NSKeyedUnarchiver.unarchiveObject(with: binaryData) as! Self
	}
	
}

// MARK: - Array

extension Array: CollectionDataConvertible {
	
}

// MARK: - Set

extension Set: CollectionDataConvertible {
	
}

// MARK: - Dictionary

extension Dictionary: CollectionDataConvertible {
	
}