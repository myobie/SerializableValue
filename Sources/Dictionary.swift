import Foundation

public struct Dictionary {
	public var rawDictionary: [String: Value]
	
	public init() {
		self.rawDictionary = [:]
	}
	
	public init(_ dictionary: [String: Value]) {
		self.rawDictionary = dictionary
	}
	
	public init?(_ dictionary: [AnyHashable: Any]) {
		var result = [String: Value]()
		for (key, value) in dictionary {
			guard let key = key as? String,
				let value = SerializableValues.Value(value)
				else { return nil }
			result[key] = value
		}
		self.rawDictionary = result
	}
}

extension Dictionary: Collection, ConvertibleDictionary {
	public typealias Key = String
	public typealias Value = SerializableValues.Value
	public typealias Element = (key: Key, value: Value)
	public typealias Index = DictionaryIndex<Key, Value>
	
	public var startIndex: Index {
		return rawDictionary.startIndex
	}
	
	public var endIndex: Index {
		return rawDictionary.endIndex
	}
	
	public func index(after i: Index) -> Index {
		return rawDictionary.index(after: i)
	}
	
	public subscript(position: Index) -> Element {
		get {
			return rawDictionary[position]
		}
	}
	
	public subscript(key: Key) -> Value? {
		get {
			return rawDictionary[key]
		}
		set(newValue) {
			rawDictionary[key] = newValue
		}
	}
}
