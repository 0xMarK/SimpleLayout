//
//  SizeCalculatable.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import CoreGraphics

public protocol SizeCalculatable {
    
    associatedtype Model
    
    static func size(for model: Model, constraintTo size: CGSize) -> CGSize
    
}
