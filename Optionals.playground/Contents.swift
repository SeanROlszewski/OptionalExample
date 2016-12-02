postfix operator /!

enum MyOptional<T>: Equatable, ExpressibleByNilLiteral {
    
    case some(T)
    case none
    
    public init(nilLiteral: ()) {
        self = .none
    }
    
    public init(some: T) {
        self = .some(some)
    }
    
    static postfix internal func /! (operand: MyOptional<T>) -> T {
        switch operand {
        case .some(let value):
            return value
        default:
            fatalError("Unexpectedly found nil when unwrapping the MyOptional type")
        }
    }
}

func ==<T>(lhs: MyOptional<T>, rhs: _OptionalNilComparisonType) -> Bool {
    switch (lhs) {
    case .some(_):
        return false
    case .none:
        return true
    }
}

func ==<T>(lhs: MyOptional<T>, rhs: MyOptional<T>) -> Bool {
    switch (lhs, rhs) {
    case (.some(_), .some(_)):
        return true
    case (.none, .none):
        return true
    default:
        return false
    }
}

let x = MyOptional<Int>.some(1)
let y: MyOptional<Int> = nil
let z = MyOptional<Int>.some(1)
let a = MyOptional<Int>.some(2)

struct MyObject {}

let foo = MyOptional(some: MyObject())

print(x/!)
print(x == y)
print(x == z)
print(x == a)
if y == nil {
    print("y is nil")
}
y/! // Intentionally crash.
