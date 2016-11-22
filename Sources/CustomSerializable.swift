import Foundation

public protocol CustomSerializable {
	init?(_ dictionary: SerializableDictionary)
	init?(_ dictionary: SerializableDictionary?)
	var dictionary: SerializableDictionary { get }
}

extension CustomSerializable {
	public init?(_ dictionary: SerializableDictionary?) {
		guard let dictionary = dictionary else { return nil }
		self.init(dictionary)
	}
}
