import Foundation

extension Value {
    public init(_ array: Array) { self = .array(array) }
    public init(_ array: [Value]) { self = .array(Array(array)) }
    public init(_ bool: Bool) { self = .bool(bool) }
    public init(_ custom: Custom) { self = .custom(custom) }
    public init(_ date: Date) { self = .date(date) }
    public init(_ dictionary: Dictionary) { self = .dictionary(dictionary) }
    public init(_ dictionary: [String: Value]) { self = .dictionary(Dictionary(dictionary)) }
    public init(_ double: Double) { self = .double(double) }
    public init(_ float: Float) { self = .float(float) }
    public init(_ int: Int) { self = .int(int) }
    public init(_ optional: OptionalValue) { self = .optional(optional) }
    public init(_ string: String) { self = .string(string) }
    public init(_ string: NSString) { self = .string(string as String) }
    public init(_ url: URL) { self = .url(url) }
    
    // don't allow double wrapping
    public init(_ value: Value) { self = value }

    public init?(_ any: Any) {
        if let any = any as? [Any],
           let array = Array(any) {
            self.init(array)
        } else if let any = any as? [AnyHashable: Any],
                  let dictionary = Dictionary(any) {
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
