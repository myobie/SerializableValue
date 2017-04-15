import XCTest
import SerializableValues

private struct FakeUserForCustomTest: Custom {
	let id: Int
	let name: String

	init(id: Int, name: String) {
		self.id = id
		self.name = name
	}

	init?(_ serializableValue: Value) {
		if
            let dictionary = serializableValue.dictionaryValue,
			let id = dictionary.intValue("id"),
			let name = dictionary.stringValue("name") {

			self.init(id: id, name: name)
		} else {
			return nil
		}
	}

	var serializableValue: Value {
		let dict: [String: Value] = [
			"id": .int(id),
			"name": .string(name)
		]
		return Value(dict)
	}
}

class SerializableValueTests: XCTestCase {
	func testValueWrapsArray() {
		let array = Array([.int(1)])
		let value = Value(array)

		XCTAssertEqual(
            [1],
            value.arrayValue!.map({ $0.intValue! })
        )
        
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
        
		XCTAssertEqual(
            [1],
            value.optionalValue.arrayValue!.map({ $0.intValue! })
        )
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsBool() {
		let value = Value(false)

		XCTAssertNil(value.arrayValue)
        
		XCTAssertEqual(false, value.boolValue)
        
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
        
		XCTAssertEqual(false, value.optionalValue.boolValue)
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsCustom() {
		let user = FakeUserForCustomTest(id: 1, name: "Nathan")
		let value = Value(user)
        
        let custom = value.customValue as! FakeUserForCustomTest
        

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
        
        XCTAssertEqual(1, custom.id)
        XCTAssertEqual("Nathan", custom.name)
		
		XCTAssertNil(value.dateValue)
        
		XCTAssertEqual(
            "Nathan",
            value.dictionaryValue!.stringValue("name")
        )
        XCTAssertEqual(
            1,
            value.dictionaryValue!.intValue("id")
        )
        
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
        
		XCTAssertEqual(
            "Nathan",
            value.optionalValue.dictionaryValue!.stringValue("name")
        )
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsDate() {
		let ago = Date(timeIntervalSince1970: 0)
		let agoString = "1970-01-01T00:00:00Z"
		let value = Value(ago)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
        
		XCTAssertEqual(ago, value.dateValue)
        
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
        
		XCTAssertEqual(ago, value.optionalValue.dateValue)
		XCTAssertEqual(agoString, value.stringValue) // Date -> String doesn't lose information
		XCTAssertNil(value.urlValue)
	}
    
    func testValueWrapsDateAsString() {
        let ago = Date(timeIntervalSince1970: 0)
        let agoString = "1970-01-01T00:00:00Z"
        let value = Value(agoString)
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        
        XCTAssertEqual(ago, value.dateValue) // String -> Date doesn't lose information
        
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(ago, value.optionalValue.dateValue)
        XCTAssertEqual(agoString, value.stringValue)
        XCTAssertEqual(URL(string: agoString), value.urlValue)
    }
    
    func testValueWrapsDictionary() {
        let dict: [String: Int] = ["one": 1, "two": 2]
        let value = Value(dict)!
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        
        XCTAssertEqual(1, value.dictionaryValue!.intValue("one"))
        XCTAssertEqual(2, value.dictionaryValue!.intValue("two"))
        
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(
            1,
            value.optionalValue.dictionaryValue!.intValue("one")
        )
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsDouble() {
        let value = Value(Double(1.0))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        
        XCTAssertEqual(1.0, value.doubleValue)
        
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(1.0, value.optionalValue.doubleValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsFloat() {
        let value = Value(Float(1.0))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        
        XCTAssertEqual(1.0, value.doubleValue) // Float -> Double doesn't lose information
        XCTAssertEqual(1.0, value.floatValue)
        
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(1.0, value.optionalValue.floatValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }

	func testValueWrapsInt() {
		let value = Value(1)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
        
		XCTAssertEqual(1.0, value.doubleValue) // Int -> Double doesn't lose information
		XCTAssertEqual(1.0, value.floatValue) // Int -> Float doesn't lose information
		XCTAssertEqual(1, value.intValue)
        
		XCTAssertEqual(1, value.optionalValue.intValue)
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}
    
    func testValueWrapsOptionalString() {
        let value: Value = .optional(.string("woo"))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual("woo", value.optionalValue.stringValue)
        XCTAssertEqual("woo", value.stringValue)
        XCTAssertEqual(URL(string: "woo"), value.urlValue)
    }
    
    func testValueWrapsOptionalNone() {
        let value: Value = .optional(.int(nil))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertNil(value.optionalValue.intValue)
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }

	func testValueWrapsStringValue() {
        let value: Value = .string("woo")
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual("woo", value.optionalValue.stringValue)
        XCTAssertEqual("woo", value.stringValue)
        XCTAssertEqual(URL(string: "woo"), value.urlValue)
	}

	func testValueWrapsURLValue() {
		let url: URL = URL(string: "http://example.com/")!
        let value: Value = .url(url)
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(url, value.optionalValue.urlValue)
        XCTAssertEqual("http://example.com/", value.stringValue)
        XCTAssertEqual(url, value.urlValue)
	}
}
