import Foundation

protocol ConvertibleDictionary {
	associatedtype Key
	typealias Value = SerializableValues.Value
	associatedtype Index
	associatedtype Element
	
	subscript(key: Key) -> Value? { get set }
	
	func arrayValue(_ key: Key) -> Array?
	func boolValue(_ key: Key) -> Bool?
	func customValue(_ key: Key) -> Custom?
	func dateValue(_ key: Key) -> Date?
	func dictionaryValue(_ key: Key) -> Dictionary?
	func doubleValue(_ key: Key) -> Double?
	func floatValue(_ key: Key) -> Float?
	func intValue(_ key: Key) -> Int?
	func optionalValue(_ key: Key) -> OptionalValue?
	func stringValue(_ key: Key) -> String?
	func urlValue(_ key: Key) -> URL?
}

extension ConvertibleDictionary {
	public func arrayValue(_ key: Key) -> Array? {
		return self[key]?.arrayValue
	}
	
	public func boolValue(_ key: Key) -> Bool? {
		return self[key]?.boolValue
	}

	public func customValue(_ key: Key) -> Custom? {
		return self[key]?.customValue
	}
	
	public func dateValue(_ key: Key) -> Date? {
		return self[key]?.dateValue
	}

	public func dictionaryValue(_ key: Key) -> Dictionary? {
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

	public func optionalValue(_ key: Key) -> OptionalValue? {
		return self[key]?.optionalValue
	}
	
	public func stringValue(_ key: Key) -> String? {
		return self[key]?.stringValue
	}
	
	public func urlValue(_ key: Key) -> URL? {
		return self[key]?.urlValue
	}
}
