//
//  Random.swift
//  BasicKit
//
//  Created by Fri. on 2022/9/23.
//

import Foundation
import UIKit

public
extension UIColor {
  static var random: UIColor {
    UIColor(red: CGFloat.random(in: 0..<256)/256.0,
            green: CGFloat.random(in: 0..<256)/256.0,
            blue: CGFloat.random(in: 0..<256)/256.0,
            alpha: 1)
  }
}

public
func randomNumber(count: Int) -> [Int] {
  var res = [Int]()
  res.reserveCapacity(count)
  (0..<count).map { _ in
    Int.random(in: 0...10000)
  }
  .forEach{
    res.append($0)
  }
  return res
}
