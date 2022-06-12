//
//  NSObjectHelper.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 05/06/21.
//

import UIKit

extension NSObject {
    public class var className: String {
        return String(describing: self)
    }
}
