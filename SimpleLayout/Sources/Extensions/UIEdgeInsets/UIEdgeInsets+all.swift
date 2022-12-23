//
//  UIEdgeInsets+all.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 23.12.2022.
//

import UIKit

extension UIEdgeInsets {
    
    public static func all(_ inset: CGFloat = 0) -> UIEdgeInsets {
        Self(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}
