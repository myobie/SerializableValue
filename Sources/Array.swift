import Foundation

public struct Array {
	public var rawArray: [Value]
	
	public init() {
		self.rawArray = []
	}
	
	public init(_ array: [Value]) {
		self.rawArray = array
	}
	
	public init(_ array: [Custom]) {
		self.rawArray = array.map { .custom($0) }
	}
	
	public init?(_ array: [Any]) {
		var result = [Value]()
		for item in array {
			guard let item = Value(item) else { return nil }
			result.append(item)
		}
		self.init(result)
	}
}

extension Array: Collection {
	public typealias Index = Int
	public typealias Element = Value
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
