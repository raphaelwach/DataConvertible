import XCTest
@testable import DataConvertible

final class DataConvertibleTests: XCTestCase {
	
	// MARK: - Generic test
	
	func isBinaryDataOK(from dc: DataConvertible, expectedBase64EncodedData eb64ed: String) -> Data {
		let convertedValue = dc.binaryData
		XCTAssertEqual(convertedValue.base64EncodedString(),
					   eb64ed,
					   "Wrong value \(convertedValue.base64EncodedString()) after conversion of \(dc). It should have been \(eb64ed)")
		return convertedValue
	}
	
	func isValueOK<T: NumberDataConvertible>(from data: Data, expectedValue ev: T?) -> T? {
		let value: T? = T(binaryData: data)
		XCTAssertEqual(value,
					   ev,
					   "Wrong value \(String(describing: value)) after conversion of \(data.base64EncodedString()). It should have been \(String(describing: ev))")
		return value
	}
	
	// MARK: - Tests String
	
	func testString() {
		
		var str = ""
		var bd = str.binaryData
		var value = String(binaryData: bd)
		XCTAssertEqual(str, value, "Wrong value \(String(describing: value)) after conversion of \(str).")
		str = "123456789"
		bd = str.binaryData
		value = String(binaryData: bd)
		XCTAssertEqual(str, value, "Wrong value \(String(describing: value)) after conversion of \(str).")
		str =
		"""
		Je suis le Ténébreux, – le Veuf, – l’Inconsolé,
		Le Prince d’Aquitaine à la Tour abolie :
		Ma seule Etoile est morte, – et mon luth constellé
		Porte le Soleil noir de la Mélancolie.
		Dans la nuit du Tombeau, Toi qui m’as consolé,
		Rends-moi le Pausilippe et la mer d’Italie,
		La fleur qui plaisait tant à mon coeur désolé,
		Et la treille où le Pampre à la Rose s’allie.
		Suis-je Amour ou Phébus ?… Lusignan ou Biron ?
		Mon front est rouge encor du baiser de la Reine ;
		J’ai rêvé dans la Grotte où nage la sirène…
		Et j’ai deux fois vainqueur traversé l’Achéron :
		Modulant tour à tour sur la lyre d’Orphée
		Les soupirs de la Sainte et les cris de la Fée.
		Gérard de Nerval
		"""
		bd = str.binaryData
		value = String(binaryData: bd)
		XCTAssertEqual(str, value, "Wrong value \(String(describing: value)) after conversion of \(str).")
		let strOptional: String? = nil
		let bdOptional = strOptional?.binaryData
		XCTAssertNil(bdOptional, "Converting a nil String? to Data should produce nil")
    }
	
	// MARK: - Tests Int
	
	func testInt() {
		
		var value: Int = 0
		var bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAAAAA=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = 42
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "KgAAAAAAAAA=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = -42
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "1v////////8=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Int.max
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "/////////38=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Int.min
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAAAIA=")
		_ = isValueOK(from: bd, expectedValue: value)
	}
	
	// MARK: - Tests Double
	
	func testDouble() {
		var value: Double = 0.0
		var bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAAAAA=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = 42.0
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAARUA=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = -42.0
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAARcA=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Double(Int.max) * 2.0 + 0.000000000000042
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAA8EM=")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Double(Int.min) * 2.0 - 0.000000000000042
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAAAA8MM=")
		_ = isValueOK(from: bd, expectedValue: value)
	}
	
	// MARK: - Tests Float
	
	func testFloat() {
		var value: Float = 0.0
		var bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAAAA==")
		_ = isValueOK(from: bd, expectedValue: value)
		value = 42.0
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAoQg==")
		_ = isValueOK(from: bd, expectedValue: value)
		value = -42.0
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AAAowg==")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Float(Int.max) * 2.0 + 0.000000000000042
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AACAXw==")
		_ = isValueOK(from: bd, expectedValue: value)
		value = Float(Int.min) * 2.0 - 0.000000000000042
		bd = isBinaryDataOK(from: value, expectedBase64EncodedData: "AACA3w==")
		_ = isValueOK(from: bd, expectedValue: value)
	}

	// MARK: - Tests Date
	
	func testDate() {
		var value: Date = Date(timeIntervalSince1970: 1534951752.507499)
		var bd = isBinaryDataOK(from: value, expectedBase64EncodedData: 1534951752.507499.binaryData.base64EncodedString())
		var date = Date(binaryData: bd)
		XCTAssertEqual(date?.timeIntervalSince1970,
					   value.timeIntervalSince1970,
					   "Wrong value \(String(describing: date)) after conversion of \(bd.base64EncodedString()). It should have been \(String(describing: 1534951752.507499.binaryData.base64EncodedString()))")
		value = Date()
		bd = value.binaryData
		date = Date(binaryData: bd)
		XCTAssertEqual(date?.timeIntervalSince1970,
					   value.timeIntervalSince1970,
					   "Wrong value \(String(describing: date)) after conversion of \(bd.base64EncodedString()). \(value) and \(String(describing: date)) should be equal.")
	}

	// MARK: - Tests Collections
	
	// MARK: - Tests Array
	
	func testArray() {
		let arrayInt: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		var bd = arrayInt.binaryData
		let valueInt = [Int](binaryData: bd)
		XCTAssertEqual(arrayInt, valueInt, "Wrong value \(arrayInt) and \(String(describing: valueInt)) should be equal.")
		
		let arrayString: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
		bd = arrayString.binaryData
		let valueString = [String](binaryData: bd)
		XCTAssertEqual(arrayString, valueString, "Wrong value \(arrayString) and \(String(describing: valueString)) should be equal.")
		
		let arrayEmpty: [Int] = []
		bd = arrayEmpty.binaryData
		let valueEmpty: [Int] = [Int](binaryData: bd)!
		let areArraysEquals = arrayEmpty.elementsEqual(valueEmpty)
		XCTAssertEqual(arrayEmpty, valueEmpty, "Wrong value \(arrayInt) and \(String(describing: valueInt)) should be equal.")
		XCTAssertTrue(areArraysEquals, "Wrong value \(arrayEmpty) and \(String(describing: valueEmpty)) should be equal.")
	}
	
	// MARK: - Tests Dictionary
	
	func testDictionary() {
		let dInt = [1 : 1, 2 : 2, 3 : 3, 4 : 4, 5 : 5]
		let bdDInt = dInt.binaryData
		let valueDInt = [Int : Int](binaryData: bdDInt)
		XCTAssertEqual(dInt, valueDInt, "Wrong value \(dInt) and \(String(describing: valueDInt)) should be equal.")
		
		let dStr = ["1" : "1", "2" : "2", "3" : "3", "4" : "4", "5" : "5"]
		let bdDStr = dStr.binaryData
		let valueDStr = [String : String](binaryData: bdDStr)
		XCTAssertEqual(dStr, valueDStr, "Wrong value \(dStr) and \(String(describing: valueDStr)) should be equal.")
	}
	
    static var allTests = [
		("testString", testString),
        ("testInt", testInt),
		("testDouble", testDouble),
		("testFloat", testFloat),
		("testDate", testDate),
		("testArray", testArray),
		("testDictionary", testDictionary)
    ]
}
