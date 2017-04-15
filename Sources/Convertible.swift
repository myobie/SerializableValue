import Foundation

protocol Convertible {
    var arrayValue: Array? { get }
    var boolValue: Bool? { get }
	var customValue: Custom? { get }
    var dateValue: Date? { get }
    var dictionaryValue: Dictionary? { get }
    var doubleValue: Double? { get }
    var floatValue: Float? { get }
    var intValue: Int? { get }
	var optionalValue: OptionalValue { get }
    var stringValue: String? { get }
    var urlValue: URL? { get }
}
