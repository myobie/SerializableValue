import Foundation

public enum Value {
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
