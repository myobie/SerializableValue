import Foundation

public protocol CustomSerializable {
	init?(_ serializableValue: SerializableValue)
	init?(_ serializableValue: SerializableValue?)
	var serializableValue: SerializableValue { get }
}

extension CustomSerializable {
	public init?(_ serializableValue: SerializableValue?) {
		guard let serializableValue = serializableValue else { return nil }
		self.init(serializableValue)
	}
}
