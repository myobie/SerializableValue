import Foundation

protocol SerializableConvertible {
    var arrayValue: SerializableArray? { get }
    var boolValue: Bool? { get }
	var customValue: CustomSerializable? { get }
    var dateValue: Date? { get }
    var dictionaryValue: SerializableDictionary? { get }
    var doubleValue: Double? { get }
    var floatValue: Float? { get }
    var intValue: Int? { get }
    var nullValue: NSNull { get }
    var numberValue: NSNumber? { get }
	var optionalValue: SerializableOptionalValue? { get }
    var stringValue: String? { get }
    var urlValue: URL? { get }
}
