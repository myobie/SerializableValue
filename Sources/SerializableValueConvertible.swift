import Foundation

extension SerializableValue: SerializableConvertible {
	public var arrayValue: SerializableArray? {
		switch self {
		case .optional(let value):
			return value.arrayValue
		case .array(let value):
			return value
		default:
			return nil
		}
	}
	
	public var boolValue: Bool? {
		switch self {
		case .optional(let value):
			return value.boolValue
		case .number(let value):
			// They seem to have memoized the NSNumber instances they use to represent boolean values,
			// so we can compare identity to see if we have a boolean or not
			if value === trueNumber || value === falseNumber {
				return value.boolValue
			} else {
				return nil
			}
		case .bool(let value):
			return value
		default:
			return nil
		}
	}
	
	public var customValue: CustomSerializable? {
		switch self {
		case .custom(let value):
			return value
		default:
			return nil
		}
	}

	public var dateValue: Date? {
		switch self {
		case .optional(let value):
			return value.dateValue
		case .string(let value):
            if #available(OSX 10.12, *) {
                return ISO8601DateFormatter().date(from: value)
            } else {
                return nil
            }
		case .date(let value):
			return value
		default:
			return nil
		}
	}
	
	public var dictionaryValue: SerializableDictionary? {
		switch self {
		case .optional(let value):
			return value.dictionaryValue
		case .custom(let value):
			return value.serializableValue.dictionaryValue
		case .dictionary(let value):
			return value
		default:
			return nil
		}
	}
	
	public var doubleValue: Double? {
		switch self {
		case .optional(let value):
			return value.doubleValue
		case .number(let value):
			if value === trueNumber || value === falseNumber {
				return nil
			} else {
				return value.doubleValue
            }
		case .int(let value):
			return Double(value)
		case .float(let value):
			return Double(value)
		case .double(let value):
			return value
		default:
			return nil
		}
	}
	
	public var floatValue: Float? {
		switch self {
		case .optional(let value):
			return value.floatValue
		case .number(let value):
			if value === trueNumber || value === falseNumber {
				return nil
			} else {
				return value.floatValue
            }
		case .int(let value):
			return Float(value)
		case .float(let value):
			return value
		default:
			return nil
		}
	}
	
	public var intValue: Int? {
		switch self {
		case .optional(let value):
			return value.intValue
		case .number(let value):
			if value === trueNumber || value === falseNumber {
				return nil
			} else {
				// Is it an Int? Is there a better way to do this?
				if value.isEqual(to: NSNumber(integerLiteral: value.intValue)) {
					return value.intValue
				} else {
					return nil
				}
			}
		case .int(let value):
			return value
		default:
			return nil
		}
	}
	
	public var nullValue: NSNull { return NSNull() }
	
	public var numberValue: NSNumber? {
		switch self {
		case .optional(let value):
			return value.numberValue
		case .number(let value):
			if value === trueNumber || value === falseNumber {
				return nil
			} else {
				return value
			}
		case .double(let value):
			return NSNumber(floatLiteral: value)
		case .float(let value):
			return NSNumber(floatLiteral: Double(value))
		case .int(let value):
			return NSNumber(integerLiteral: value)
		default:
			return nil
		}
	}

	public var optionalValue: SerializableOptionalValue {
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
        case .null:
            return .null
        case .number(let value):
            return .number(value)
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
		case .optional(let value):
			return value.stringValue
		case .date(let value):
            if #available(OSX 10.12, *) {
                return ISO8601DateFormatter().string(from: value)
            } else {
                return nil
            }
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
		case .optional(let value):
			return value.urlValue
		case .url(let value):
			return value
		case .string(let value):
			return URL(string: value)
		default:
			return nil
		}
	}
}
