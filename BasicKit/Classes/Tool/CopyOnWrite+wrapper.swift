//
//  CopyOnWrite.swift
//  BasicKit
//
//  Created by Fri on 2022/9/9.
//

fileprivate final class Ref<T> {
  var val: T
  init(_ v: T) {val = v}
}

@propertyWrapper
public struct CoW<T> {
  public var wrappedValue: T {
    get { value }
    set { value = newValue }
  }
  
  public init(wrappedValue: T) {
    self.init(wrappedValue)
  }
  
  private var ref: Ref<T>
  init(_ x: T) { ref = Ref(x) }
  
  var value: T {
    get { return ref.val }
    set {
      if !isKnownUniquelyReferenced(&ref) {
        ref = Ref(newValue)
        return
      }
      ref.val = newValue
    }
  }
}

//MARK: -

extension CoW: Equatable where T: Equatable {}
extension CoW: Hashable where T: Hashable {}

extension CoW: Codable where T: Codable, T: ExpressibleByNilLiteral {
  public init(from decoder: Decoder) throws {
    let container = try? decoder.singleValueContainer()
    if let value = try? container?.decode(T.self) {
      ref = Ref(value)
    } else {
      ref = Ref(nil)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    try wrappedValue.encode(to: encoder)
  }
}

extension CoW: OmittableType where T: ExpressibleByNilLiteral {
  static var nilValue: Self { .init(wrappedValue: nil) }
}

extension Ref: Codable where T: Codable {}

extension Ref: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
  var debugDescription: String { val.debugDescription }
}

extension Ref: Equatable where T: Equatable {
  static func == (lhs: Ref<T>, rhs: Ref<T>) -> Bool {
    lhs.val == rhs.val
  }
}

extension Ref: Hashable where T: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(val)
  }
}
