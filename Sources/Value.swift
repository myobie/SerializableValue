import Foundation

public enum Value: Equatable {
	case array(Array)
	case bool(Bool)
	case custom(Custom)
	case date(Date)
	case dictionary(Dictionary)
	case double(Double)
	case float(Float)
	case int(Int)
	case optional(OptionalValue)
	case string(String)
	case url(URL)
}

public func ==(lhs: Value, rhs: Value) -> Bool {
    switch (lhs, rhs) {
    case (.array(let left), .array(let right)):
        return left == right
    case (.bool(let left), .bool(let right)):
        return left == right
    case (.date(let left), .date(let right)):
        return left == right
    case (.dictionary(let left), .dictionary(let right)):
        return left == right
    case (.double(let left), .double(let right)):
        return left == right
    case (.float(let left), .float(let right)):
        return left == right
    case(.int(let left), .int(let right)):
        return left == right
    case (.optional(let left), .optional(let right)):
        return left == right
    case (.string(let left), .string(let right)):
        return left == right
    case (.url(let left), .url(let right)):
        return left == right
    default:
        return false
    }
}
