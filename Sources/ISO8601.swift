import Foundation

public func ISO8601DateFormatter() -> DateFormatter {
	let kISO8601DateFormatterKey = "serializable.ISO8601DateFormatter"
	let threadDictionary = Thread.current.threadDictionary
	if let formatter = threadDictionary[kISO8601DateFormatterKey] as? DateFormatter {
		return formatter
	} else {
		let formatter = DateFormatter.iso8601()
		threadDictionary[kISO8601DateFormatterKey] = formatter
		return formatter
	}
}

internal extension DateFormatter {
	class func iso8601() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
		return formatter
	}
}
