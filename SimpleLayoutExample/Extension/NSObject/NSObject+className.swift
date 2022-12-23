//
//  NSObject+className.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import Foundation

extension NSObject {
    
    public class var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return String(describing: type(of: self))
    }
    
}
