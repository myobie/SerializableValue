import Foundation

public enum SerializableOptionalValue {
	case array(SerializableArray?)
	case bool(Bool?)
	case custom(CustomSerializable?)
	case date(Date?)
	case dictionary(SerializableDictionary?)
	case double(Double?)
	case float(Float?)
	case int(Int?)
	case null
	case number(NSNumber?)
	case string(String?)
	case url(URL?)
	
	public var serializableValue: SerializableValue {
		// convert to specific type or .null for each type
		switch self {
		case .array(let value):
			if let value = value {
				return .array(value)
			} else {
				return .null
			}
		case .bool(let value):
			if let value = value {
				return .bool(value)
			} else {
				return .null
			}
		case .custom(let value):
			if let value = value {
				return .custom(value)
			} else {
				return .null
			}
		case .date(let value):
			if let value = value {
				return .date(value)
			} else {
				return .null
			}
		case .dictionary(let value):
			if let value = value {
				return .dictionary(value)
			} else {
				return .null
			}
		case .double(let value):
			if let value = value {
				return .double(value)
			} else {
				return .null
			}
		case .float(let value):
			if let value = value {
				return .float(value)
			} else {
				return .null
			}
		case .int(let value):
			if let value = value {
				return .int(value)
			} else {
				return .null
			}
		case .null:
			return .null
		case .number(let value):
			if let value = value {
				return .number(value)
			} else {
				return .null
			}
		case .string(let value):
			if let value = value {
				return .string(value)
			} else {
				return .null
			}
		case .url(let value):
			if let value = value {
				return .url(value)
			} else {
				return .null
			}
		}
	}
}

extension SerializableOptionalValue: SerializableConvertible {
	public var arrayValue: SerializableArray? {
		return serializableValue.arrayValue
	}
	
	public var boolValue: Bool? {
		return serializableValue.boolValue
	}

	public var customValue: CustomSerializable? {
		return serializableValue.customValue
	}
	
	public var dateValue: Date? {
		return serializableValue.dateValue
	}
	
	public var dictionaryValue: SerializableDictionary? {
		return serializableValue.dictionaryValue
	}
	
	public var doubleValue: Double? {
		return serializableValue.doubleValue
	}
	
	public var floatValue: Float? {
		return serializableValue.floatValue
	}
	
	public var intValue: Int? {
		return serializableValue.intValue
	}
	
	public var nullValue: NSNull { return NSNull() }
	
	public var numberValue: NSNumber? {
		return serializableValue.numberValue
	}

	public var optionalValue: SerializableOptionalValue? {
		return serializableValue.optionalValue
	}
	
	public var stringValue: String? {
		return serializableValue.stringValue
	}
	
	public var urlValue: URL? {
		return serializableValue.urlValue
	}
}
