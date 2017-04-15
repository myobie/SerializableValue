import Foundation

public enum OptionalValue: Equatable {
	case array(Array?)
	case bool(Bool?)
	case custom(Custom?)
	case date(Date?)
	case dictionary(Dictionary?)
	case double(Double?)
	case float(Float?)
	case int(Int?)
	case string(String?)
	case url(URL?)
	
	public var serializableValue: Value? {
		// convert to specific type or .null for each type
		switch self {
		case .array(let value):
			if let value = value {
				return .array(value)
			} else {
				return nil
			}
		case .bool(let value):
			if let value = value {
				return .bool(value)
			} else {
				return nil
			}
		case .custom(let value):
			if let value = value {
				return .custom(value)
			} else {
				return nil
			}
		case .date(let value):
			if let value = value {
				return .date(value)
			} else {
				return nil
			}
		case .dictionary(let value):
			if let value = value {
				return .dictionary(value)
			} else {
				return nil
			}
		case .double(let value):
			if let value = value {
				return .double(value)
			} else {
				return nil
			}
		case .float(let value):
			if let value = value {
				return .float(value)
			} else {
				return nil
			}
		case .int(let value):
			if let value = value {
				return .int(value)
			} else {
				return nil
			}
		case .string(let value):
			if let value = value {
				return .string(value)
			} else {
				return nil
			}
		case .url(let value):
			if let value = value {
				return .url(value)
			} else {
				return nil
			}
		}
	}
}

public func ==(lhs: OptionalValue, rhs: OptionalValue) -> Bool {
    return lhs.serializableValue == rhs.serializableValue
}

extension OptionalValue: Convertible {
	public var arrayValue: Array? {
		return serializableValue?.arrayValue
	}
	
	public var boolValue: Bool? {
		return serializableValue?.boolValue
	}

	public var customValue: Custom? {
		return serializableValue?.customValue
	}
	
	public var dateValue: Date? {
		return serializableValue?.dateValue
	}
	
	public var dictionaryValue: Dictionary? {
		return serializableValue?.dictionaryValue
	}
	
	public var doubleValue: Double? {
		return serializableValue?.doubleValue
	}
	
	public var floatValue: Float? {
		return serializableValue?.floatValue
	}
	
	public var intValue: Int? {
		return serializableValue?.intValue
	}

	public var optionalValue: OptionalValue {
		return self
	}
	
	public var stringValue: String? {
		return serializableValue?.stringValue
	}
	
	public var urlValue: URL? {
		return serializableValue?.urlValue
	}
}
