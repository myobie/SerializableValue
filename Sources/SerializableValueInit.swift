import Foundation

extension SerializableValue {
    public init(_ array: SerializableArray) { self = .array(array) }
    public init(_ array: [SerializableValue]) { self = .array(SerializableArray(array)) }
    public init(_ bool: Bool) { self = .bool(bool) }
    public init(_ custom: CustomSerializable) { self = .custom(custom) }
    public init(_ date: Date) { self = .date(date) }
    public init(_ dictionary: SerializableDictionary) { self = .dictionary(dictionary) }
    public init(_ dictionary: [String: SerializableValue]) { self = .dictionary(SerializableDictionary(dictionary)) }
    public init(_ double: Double) { self = .double(double) }
    public init(_ float: Float) { self = .float(float) }
    public init(_ int: Int) { self = .int(int) }
    public init(_ null: NSNull) { self = .null }
    public init(_ number: NSNumber) { self = .number(number) }
    public init(_ optional: SerializableOptionalValue) { self = .optional(optional) }
    public init(_ string: String) { self = .string(string) }
    public init(_ string: NSString) { self = .string(string as String) }
    public init(_ url: URL) { self = .url(url) }
    
    // don't allow double wrapping
    public init(_ value: SerializableValue) { self = value }

    public init?(_ any: Any) {
        // NSNumber MUST come first or else it might auto-convert to another type
        if let number = any as? NSNumber {
            self.init(number)
        } else if any is NSNull {
            self.init(NSNull())
        } else if let any = any as? [Any],
           let array = SerializableArray(any) {
            self.init(array)
        } else if let any = any as? [AnyHashable: Any],
                  let dictionary = SerializableDictionary(any) {
            self.init(dictionary)
        } else if let date = any as? Date {
            self.init(date)
        } else if let int = any as? Int { // Int is less greedy, so it comes before Double and Float
            self.init(int)
        } else if let double = any as? Double {
            self.init(double)
        } else if let float = any as? Float {
            self.init(float)
        } else if let string = any as? String {
            self.init(string)
        } else if let url = any as? URL {
            self.init(url)
        } else if let bool = any as? Bool { // lots of things convert to bools, so this should come last
            self.init(bool)
        } else {
            return nil // all unknown types fail to initialize
        }
    }
}
