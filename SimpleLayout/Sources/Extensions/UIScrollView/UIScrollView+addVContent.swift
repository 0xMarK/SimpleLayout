//
//  UIScrollView+addVContent.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 23.12.2022.
//

import UIKit

extension UIScrollView {
    
    @discardableResult
    public func addVContent<T: UIView>(_ subview: T, insets: UIEdgeInsets = .zero, then closure: ((T) -> Void) = { _ in }) -> T {
        addSubview(subview)
        subview.snap(to: contentLayoutGuide, insets: insets)
        subview.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor, constant: -(insets.left + insets.right)).isActive = true
        closure(subview)
        return subview
    }
    
}

