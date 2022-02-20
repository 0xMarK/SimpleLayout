//
//  NSObject+className.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import Foundation

extension NSObject {
    
    open class var className: String {
        return String(describing: self)
    }
    
    open var className: String {
        return String(describing: type(of: self))
    }
    
}
