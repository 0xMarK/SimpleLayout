//
//  UIView+snapToEdges.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func snapToEdges(edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero, to view: UIView? = nil) -> [NSLayoutConstraint] {
        guard let view = view ?? superview else { return [] }
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top))
        }
        if edges.contains(.bottom) {
            constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom))
        }
        if edges.contains(.left) {
            constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right))
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
}
