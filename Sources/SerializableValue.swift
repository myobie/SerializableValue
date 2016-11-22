import Foundation

public enum SerializableValue {
	case array(SerializableArray)
	case bool(Bool)
	case custom(CustomSerializable)
	case date(Date)
	case dictionary(SerializableDictionary)
	case double(Double)
	case float(Float)
	case int(Int)
	case null
	case number(NSNumber)
	case optional(SerializableOptionalValue)
	case string(String)
	case url(URL)
}
