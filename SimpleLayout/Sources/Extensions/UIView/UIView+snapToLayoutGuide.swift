//
//  UIView+snapToLayoutGuide.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 21.05.2021.
//

import UIKit

extension UIView {
    
    @discardableResult
    open func snap(to layoutGuide: UILayoutGuide, edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top))
        }
        if edges.contains(.bottom) {
            constraints.append(layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom))
        }
        if edges.contains(.left) {
            constraints.append(leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right))
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
}
