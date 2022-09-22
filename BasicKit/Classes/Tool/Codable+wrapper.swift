//
//  Codable+wrapper.swift
//  BasicKit
//
//  Created by 常仲伟 on 2021/10/21.
//

extension KeyedDecodingContainer {
  func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T where T : Decodable, T: OmittableType {
    return try decodeIfPresent(T.self, forKey: key) ?? T.nilValue
  }
}

@propertyWrapper
struct ModelEnumWrapper<T> {
  var wrappedValue: T
}

extension ModelEnumWrapper: Codable where T: Codable, T: ExpressibleByNilLiteral {
  init(from decoder: Decoder) throws {
    let container = try? decoder.singleValueContainer()
    if let value = try? container?.decode(T.self) {
      wrappedValue = value
    } else {
      wrappedValue = nil
    }
  }
  
  func encode(to encoder: Encoder) throws {
    try wrappedValue.encode(to: encoder)
  }
}

extension ModelEnumWrapper: OmittableType where T: ExpressibleByNilLiteral {
  static var nilValue: Self { .init(wrappedValue: nil) }
}

extension ModelEnumWrapper: Equatable where T: Equatable{}


