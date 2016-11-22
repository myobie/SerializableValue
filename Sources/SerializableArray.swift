import Foundation

public struct SerializableArray {
	public var rawArray: [SerializableValue]
	
	public init() {
		self.rawArray = []
	}
	
	public init(_ array: [SerializableValue]) {
		self.rawArray = array
	}
	
	public init(_ array: [CustomSerializable]) {
		self.rawArray = array.map { .custom($0) }
	}
	
	public init?(_ array: [Any]) {
		var result = [SerializableValue]()
		for item in array {
			guard let item = SerializableValue(item) else { return nil }
			result.append(item)
		}
		self.init(result)
	}
}

extension SerializableArray: Collection {
	public typealias Index = Int
	public typealias Element = SerializableValue
	public typealias Key = Int
	
	public var startIndex: Index {
		return rawArray.startIndex
	}
	
	public var endIndex: Index {
		return rawArray.endIndex
	}
	
	public func index(after i: Index) -> Index {
		return rawArray.index(after: i)
	}
	
	public subscript(position: Index) -> Element {
		return rawArray[position]
	}
}
