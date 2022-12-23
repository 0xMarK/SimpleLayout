//
//  UIView+positionCenter.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import Foundation

import UIKit

extension UIView {
    
    @discardableResult
    public func positionCenter(insets: UIEdgeInsets = .zero, to view: UIView? = nil) -> [NSLayoutConstraint] {
        guard let view = view ?? superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: insets.bottom),
            leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: insets.right)
        ])
        return constraints
    }
    
}
