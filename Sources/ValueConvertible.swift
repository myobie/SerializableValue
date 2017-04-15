import Foundation

extension Value: Convertible {
	public var arrayValue: Array? {
		switch self {
		case .array(let value):
			return value
        case .custom(let value):
            return value.serializableValue.arrayValue
        case .optional(let value):
            return value.arrayValue
		default:
			return nil
		}
	}
	
	public var boolValue: Bool? {
		switch self {
		case .bool(let value):
			return value
        case .custom(let value):
            return value.serializableValue.boolValue
        case .optional(let value):
            return value.boolValue
		default:
			return nil
		}
	}
	
	public var customValue: Custom? {
		switch self {
        case .optional(let value):
            return value.customValue
		case .custom(let value):
			return value
		default:
			return nil
		}
	}

	public var dateValue: Date? {
		switch self {
        case .custom(let value):
            return value.serializableValue.dateValue
		case .date(let value):
			return value
        case .optional(let value):
            return value.dateValue
        case .string(let value):
            if #available(OSX 10.12, *) {
                return ISO8601DateFormatter().date(from: value)
            } else {
                return nil
            }
		default:
			return nil
		}
	}
	
	public var dictionaryValue: Dictionary? {
		switch self {
		case .custom(let value):
			return value.serializableValue.dictionaryValue
		case .dictionary(let value):
			return value
        case .optional(let value):
            return value.dictionaryValue
		default:
			return nil
		}
	}
	
	public var doubleValue: Double? {
		switch self {
        case .custom(let value):
            return value.serializableValue.doubleValue
		case .double(let value):
			return value
        case .float(let value):
            return Double(value)
        case .int(let value):
            return Double(value)
        case .optional(let value):
            return value.doubleValue
		default:
			return nil
		}
	}
	
	public var floatValue: Float? {
		switch self {
        case .custom(let value):
            return value.serializableValue.floatValue
		case .float(let value):
			return value
        case .int(let value):
            return Float(value)
        case .optional(let value):
            return value.floatValue
		default:
			return nil
		}
	}
	
	public var intValue: Int? {
		switch self {
        case .custom(let value):
            return value.serializableValue.intValue
		case .int(let value):
			return value
        case .optional(let value):
            return value.intValue
		default:
			return nil
		}
	}

	public var optionalValue: OptionalValue {
        switch self {
        case .array(let value):
            return .array(value)
        case .bool(let value):
            return .bool(value)
        case .custom(let value):
            return .custom(value)
        case .date(let value):
            return .date(value)
        case .dictionary(let value):
            return .dictionary(value)
        case .double(let value):
            return .double(value)
        case .float(let value):
            return .float(value)
        case .int(let value):
            return .int(value)
        case .optional(let value):
            return value
        case .string(let value):
            return .string(value)
        case .url(let value):
            return .url(value)
        }
	}

	public var stringValue: String? {
		switch self {
        case .custom(let value):
            return value.serializableValue.stringValue
		case .date(let value):
            if #available(OSX 10.12, *) {
                return ISO8601DateFormatter().string(from: value)
            } else {
                return nil
            }
        case .optional(let value):
            return value.stringValue
		case .string(let value):
			return value
		case .url(let value):
			return value.absoluteString
		default:
			return nil
		}
	}
	
	public var urlValue: URL? {
		switch self {
        case .custom(let value):
            return value.serializableValue.urlValue
		case .optional(let value):
			return value.urlValue
        case .string(let value):
            return URL(string: value)
		case .url(let value):
			return value
		default:
			return nil
		}
	}
}
