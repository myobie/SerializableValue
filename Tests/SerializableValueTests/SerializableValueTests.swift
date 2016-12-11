import XCTest
@testable import SerializableValue

private struct FakeUserForCustomTest: CustomSerializable {
	let id: Int
	let name: String

	init(id: Int, name: String) {
		self.id = id
		self.name = name
	}

	init?(_ serializableValue: SerializableValue) {
		if
            let dictionary = serializableValue.dictionaryValue,
			let id = dictionary.intValue("id"),
			let name = dictionary.stringValue("name") {

			self.init(id: id, name: name)
		} else {
			return nil
		}
	}

	var serializableValue: SerializableValue {
		let dict: [String: SerializableValue] = [
			"id": .int(id),
			"name": .string(name)
		]
		return SerializableValue(dict)
	}
}

class SerializableValueTests: XCTestCase {
	func testValueWrapsArray() {
		let array = SerializableArray([.int(1)])
		let value = SerializableValue(array)

		XCTAssertEqual(
            [1],
            value.arrayValue!
                .map({ $0.intValue! })
        )
        
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
        
		XCTAssertEqual(
            [1],
            value.optionalValue.arrayValue!
                .map({ $0.intValue! })
        )
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsBool() {
		let value = SerializableValue(false)

		XCTAssertNil(value.arrayValue)
        
		XCTAssertEqual(false, value.boolValue)
        
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
        
		XCTAssertEqual(false, value.optionalValue.boolValue)
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsNSNumberFakeBool() {
		let value = SerializableValue(trueNumber)

		XCTAssertNil(value.arrayValue)
        
		XCTAssertEqual(true, value.boolValue)
        
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
        
		XCTAssertEqual(true, value.optionalValue.boolValue)
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsCustom() {
		let user = FakeUserForCustomTest(id: 1, name: "Nathan")
		let value = SerializableValue(user)
        
        let custom = value.customValue as! FakeUserForCustomTest
        

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
        
        XCTAssertEqual(1, custom.id)
        XCTAssertEqual("Nathan", custom.name)
		
		XCTAssertNil(value.dateValue)
        
		XCTAssertEqual(
            "Nathan",
            value.dictionaryValue?.stringValue("name")
        )
        
        XCTAssertEqual(
            1,
            value.dictionaryValue?.intValue("id")
        )
        
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
        
		XCTAssertEqual(
            "Nathan",
            value.optionalValue.dictionaryValue?
                .stringValue("name")
        )
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsDate() {
		let ago = Date(timeIntervalSince1970: 0)
		let agoString = "1970-01-01T00:00:00Z"
		let value = SerializableValue(ago)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
        
		XCTAssertEqual(ago, value.dateValue)
        
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
        
		XCTAssertEqual(ago, value.optionalValue.dateValue)
        
		XCTAssertEqual(agoString, value.stringValue) // Date -> String doesn't lose information
        
		XCTAssertNil(value.urlValue)
	}
    
    func testValueWrapsDateAsString() {
        let ago = Date(timeIntervalSince1970: 0)
        let agoString = "1970-01-01T00:00:00Z"
        let value = SerializableValue(agoString)
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        
        XCTAssertEqual(ago, value.dateValue) // String -> Date doesn't lose information
        
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        
        XCTAssertEqual(ago, value.optionalValue.dateValue)
        
        
        XCTAssertEqual(agoString, value.stringValue)
        
        XCTAssertEqual(URL(string: agoString), value.urlValue)
    }
    
    func testValueWrapsDictionary() {
        let dict: [String: Int] = ["one": 1, "two": 2]
        let value = SerializableValue(dict)!
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        
        XCTAssertEqual(1, value.dictionaryValue?.intValue("one"))
        XCTAssertEqual(2, value.dictionaryValue?.intValue("two"))
        
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        
        XCTAssertEqual(
            1,
            value.optionalValue.dictionaryValue?
                .intValue("one")
        )
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsDouble() {
        let value = SerializableValue(Double(1.0))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        
        XCTAssertEqual(1.0, value.doubleValue!)
        
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        
        XCTAssertEqual(NSNumber(value: 1.0), value.numberValue) // Double -> NSNumber doesn't lose information
        
        XCTAssertEqual(1.0, value.optionalValue.doubleValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsFloat() {
        let value = SerializableValue(Float(1.0))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        
        XCTAssertEqual(1.0, value.doubleValue) // Float -> Double doesn't lose information
        XCTAssertEqual(1.0, value.floatValue)
        
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        
        XCTAssertEqual(NSNumber(value: 1.0), value.numberValue) // Float -> NSNumber doesn't lose information
        
        XCTAssertEqual(1.0, value.optionalValue.floatValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }

	func testValueWrapsInt() {
		let value = SerializableValue(1)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
        
		XCTAssertEqual(1.0, value.doubleValue!) // Int -> Double doesn't lose information
		XCTAssertEqual(1.0, value.floatValue!) // Int -> Float doesn't lose information
		XCTAssertEqual(1, value.intValue!)
        
		XCTAssertEqual(NSNull(), value.nullValue)
        
		XCTAssertEqual(NSNumber(floatLiteral: 1.0), value.numberValue!) // Int -> NSNumber doesn't lose information
        
		XCTAssertEqual(1, value.optionalValue.intValue)
        
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}
    
    func testValueWrapsNull() {
        let value = SerializableValue.null
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(NSNull(), value.nullValue)
        
        XCTAssertNil(value.numberValue)
        
        XCTAssertEqual(NSNull(), value.optionalValue.nullValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsNumberWrappingDouble() {
        let num = NSNumber(value: Double(5.0))
        let value = SerializableValue(num)
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        
        // NSNumber happily throws information away :(
        XCTAssertEqual(5.0, value.doubleValue)
        XCTAssertEqual(5.0, value.floatValue)
        XCTAssertEqual(5, value.intValue)
        
        XCTAssertEqual(NSNull(), value.nullValue)
        
        XCTAssertEqual(num, value.numberValue)
        
        XCTAssertEqual(num, value.optionalValue.numberValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }
    
    func testValueWrapsOptionalString() {
        let value: SerializableValue = .optional(.string("woo"))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        
        XCTAssertEqual(
            SerializableValue("woo").stringValue,
            value.optionalValue.stringValue
        )
        
        XCTAssertEqual("woo", value.stringValue)
        
        XCTAssertEqual(URL(string: "woo"), value.urlValue)
    }
    
    func testValueWrapsOptionalNone() {
        let value: SerializableValue = .optional(.int(nil))
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        
        XCTAssertNil(value.intValue)
        
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        
        XCTAssertNil(value.optionalValue.intValue)
        
        XCTAssertNil(value.stringValue)
        XCTAssertNil(value.urlValue)
    }

	func testValueWrapsStringValue() {
        let value: SerializableValue = .string("woo")
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        XCTAssertNil(value.optionalValue.intValue)
        
        XCTAssertEqual("woo", value.stringValue)
        XCTAssertEqual(URL(string: "woo"), value.urlValue)
	}

	func testValueWrapsURLValue() {
		let url: URL = URL(string: "http://example.com/")!
        let value: SerializableValue = .url(url)
        
        XCTAssertNil(value.arrayValue)
        XCTAssertNil(value.boolValue)
        XCTAssertNil(value.customValue)
        XCTAssertNil(value.dateValue)
        XCTAssertNil(value.dictionaryValue)
        XCTAssertNil(value.doubleValue)
        XCTAssertNil(value.floatValue)
        XCTAssertNil(value.intValue)
        XCTAssertEqual(NSNull(), value.nullValue)
        XCTAssertNil(value.numberValue)
        XCTAssertNil(value.optionalValue.intValue)

        XCTAssertEqual("http://example.com/", value.stringValue)

        XCTAssertEqual(url, value.urlValue)
	}
}
