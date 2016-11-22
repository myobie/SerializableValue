import Foundation

protocol SerializableConvertibleDictionary {
	associatedtype Key
	typealias Value = SerializableValue
	associatedtype Index
	associatedtype Element
	
	subscript(key: Key) -> Value? { get set }
	
	func arrayValue(_ key: Key) -> SerializableArray?
	func boolValue(_ key: Key) -> Bool?
	func customValue(_ key: Key) -> CustomSerializable?
	func dateValue(_ key: Key) -> Date?
	func dictionaryValue(_ key: Key) -> SerializableDictionary?
	func doubleValue(_ key: Key) -> Double?
	func floatValue(_ key: Key) -> Float?
	func intValue(_ key: Key) -> Int?
	func nullValue(_ key: Key) -> NSNull
	func numberValue(_ key: Key) -> NSNumber?
	func optionalValue(_ key: Key) -> SerializableOptionalValue?
	func stringValue(_ key: Key) -> String?
	func urlValue(_ key: Key) -> URL?
}

extension SerializableConvertibleDictionary {
	public func arrayValue(_ key: Key) -> SerializableArray? {
		return self[key]?.arrayValue
	}
	
	public func boolValue(_ key: Key) -> Bool? {
		return self[key]?.boolValue
	}

	public func customValue(_ key: Key) -> CustomSerializable? {
		return self[key]?.customValue
	}
	
	public func dateValue(_ key: Key) -> Date? {
		return self[key]?.dateValue
	}

	public func dictionaryValue(_ key: Key) -> SerializableDictionary? {
		return self[key]?.dictionaryValue
	}

	public func doubleValue(_ key: Key) -> Double? {
		return self[key]?.doubleValue
	}
	
	public func floatValue(_ key: Key) -> Float? {
		return self[key]?.floatValue
	}
	
	public func intValue(_ key: Key) -> Int? {
		return self[key]?.intValue
	}
	
	public func nullValue(_ key: String) -> NSNull {
		return NSNull()
	}
	
	public func numberValue(_ key: Key) -> NSNumber? {
		return self[key]?.numberValue
	}

	public func optionalValue(_ key: Key) -> SerializableOptionalValue? {
		return self[key]?.optionalValue
	}
	
	public func stringValue(_ key: Key) -> String? {
		return self[key]?.stringValue
	}
	
	public func urlValue(_ key: Key) -> URL? {
		return self[key]?.urlValue
	}
}
