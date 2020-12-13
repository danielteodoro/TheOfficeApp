//
//  Showable.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 08/12/20.
//

import UIKit

protocol Showable {
  
  func toShowable() -> UIViewController
  
}

extension UIViewController: Showable {
  public func toShowable() -> UIViewController {
    return self
  }
}
