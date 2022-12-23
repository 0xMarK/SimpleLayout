//
//  UIScrollView+addHContent.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 23.12.2022.
//

import UIKit

extension UIScrollView {
    
    @discardableResult
    public func addHContent<T: UIView>(_ subview: T, insets: UIEdgeInsets = .zero, then closure: ((T) -> Void) = { _ in }) -> T {
        addSubview(subview)
        subview.snap(to: contentLayoutGuide, insets: insets)
        subview.heightAnchor.constraint(equalTo: frameLayoutGuide.heightAnchor, constant: -(insets.top + insets.bottom)).isActive = true
        closure(subview)
        return subview
    }
    
}
