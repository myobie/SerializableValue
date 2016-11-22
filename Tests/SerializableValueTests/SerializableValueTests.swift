import XCTest
@testable import SerializableValue

private struct FakeUserForCustomTest: CustomSerializable {
	let id: Int
	let name: String

	init(id: Int, name: String) {
		self.id = id
		self.name = name
	}

	init?(_ dictionary: SerializableDictionary) {
		if
			let id = dictionary.intValue("id"),
			let name = dictionary.stringValue("name") {

			self.init(id: id, name: name)
		} else {
			return nil
		}
	}

	var dictionary: SerializableDictionary {
		let dict: [String: SerializableValue] = [
			"id": .int(id),
			"name": .string(name)
		]
		return SerializableDictionary(dict)
	}
}

class SerializableValueTests: XCTestCase {
	func testValueWrapsArray() {
		let array = SerializableArray([.int(1)])
		let value = SerializableValue(array)

		XCTAssertEqual([1], value.arrayValue!.map({ $0.intValue! }))
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
		XCTAssertNil(value.optionalValue)
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsBool() {
		let value = SerializableValue(false)

		XCTAssertNil(value.arrayValue)
		XCTAssertEqual(false, value.boolValue!)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
		XCTAssertNil(value.optionalValue)
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsNSNumberFakeBool() {
		let value = SerializableValue(trueNumber)

		XCTAssertNil(value.arrayValue)
		XCTAssertEqual(true, value.boolValue!)
		XCTAssertNil(value.customValue)
		XCTAssertNil(value.dateValue)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
		XCTAssertNil(value.optionalValue)
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsCustom() {
		let user = FakeUserForCustomTest(id: 1, name: "Nathan")
		let value = SerializableValue(user)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		let custom = value.customValue as! FakeUserForCustomTest
		XCTAssertEqual(1, custom.id)
		XCTAssertEqual("Nathan", custom.name)
		XCTAssertNil(value.dateValue)
		XCTAssertEqual(user.dictionary, value.dictionaryValue!)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
		XCTAssertNil(value.optionalValue)
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}

	func testValueWrapsDate() {
		let ago = Date(timeIntervalSince1970: 0)
		let agoString = "1970-01-01T00:00:00+0000"
		let value = SerializableValue(ago)

		XCTAssertNil(value.arrayValue)
		XCTAssertNil(value.boolValue)
		XCTAssertNil(value.customValue)
		XCTAssertEqual(ago, value.dateValue!)
		XCTAssertNil(value.dictionaryValue)
		XCTAssertNil(value.doubleValue)
		XCTAssertNil(value.floatValue)
		XCTAssertNil(value.intValue)
		XCTAssertEqual(NSNull(), value.nullValue)
		XCTAssertNil(value.numberValue)
		XCTAssertNil(value.optionalValue)
		XCTAssertEqual(agoString, value.stringValue!) // Date -> String doesn't lose information
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
		XCTAssertNil(value.optionalValue)
		XCTAssertNil(value.stringValue)
		XCTAssertNil(value.urlValue)
	}
}
