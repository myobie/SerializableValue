import Foundation

public protocol Custom {
	init?(_ value: Value)
	init?(_ value: Value?)
	var serializableValue: Value { get }
}

extension Custom {
	public init?(_ value: Value?) {
		guard let value = value else { return nil }
		self.init(value)
	}
}
