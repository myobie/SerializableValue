import Foundation

public struct Array: Equatable {
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

public func ==(lhs: Array, rhs: Array) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    
    for (index, value) in lhs.enumerated() {
        guard value == rhs[index] else {
            return false
        }
    }
    
    return true
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
