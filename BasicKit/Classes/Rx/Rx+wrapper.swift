//
//  Rx+wrapper.swift
//  BasicKit
//
//  Created by Fri on 2022/9/9.
//

import RxRelay
import RxSwift
import RxCocoa

//https://gist.github.com/sgr-ksmt/2cc92d8c7d517e08767fbe296b6da720
@propertyWrapper
public struct RxProperty<T> {
  public var wrappedValue: T {
    get { relay.value }
    set { relay.accept(newValue) }
  }
  
  public var projectedValue: Observable<T> { relay.asObservable() }
  
  private let relay: BehaviorRelay<T>
  public init(wrappedValue: @autoclosure () -> T) {
    relay = .init(value: wrappedValue())
  }
}

///fix swift5.6 compile error
public extension RxProperty where T: ExpressibleByNilLiteral {
  init(wrappedValue: T) {
    relay = .init(value: wrappedValue)
  }
}

@propertyWrapper
public struct RxTrigger<T> {
  private let subject = PublishSubject<T>()
  public var wrappedValue: AnyObserver<T> {
    subject.asObserver()
  }
  public var projectedValue: Observable<T> {
    subject.asObservable()
  }
  public init(){ }
}

//@propertyWrapper
//struct RxTrigger<T> {
//  private let relay = PublishRelay<T>()
//  private let trigger: AnyObserver<T>
//  private let observable: Observable<T>
//  init() {
//    trigger = AnyObserver<T>.create(relay)
//    observable = relay.asObservable()
//  }
//
//  var wrappedValue: AnyObserver<T> {
//    trigger
//  }
//
//  var projectedValue: Observable<T> {
//    observable
//  }
//}
//extension AnyObserver {
//  static func create<E>(_ relay: PublishRelay<E>) -> AnyObserver<E> {
//    return .init { event in
//      guard case let .next(value) = event else { return }
//      relay.accept(value)
//    }
//  }
//
//  static func create<E>(_ relay: BehaviorRelay<E>) -> AnyObserver<E> {
//    return .init { event in
//      guard case let .next(value) = event else { return }
//      relay.accept(value)
//    }
//  }
//}


public class KK {
  @RxProperty public var ss: Int = 0
  @RxTrigger public var bb: AnyObserver<Void>
  public init() {
    $ss.bind {
      print($0)
    }
    ss = 10
    $bb.bind{
      print("kkkkk")
    }
    bb.onNext(())
  }
}
