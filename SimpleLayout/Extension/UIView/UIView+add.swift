//
//  UIView+add.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func add<T: UIView>(_ subview: T, insets: UIEdgeInsets = .zero, then closure: ((T) -> Void) = { _ in }) -> T {
        if let selfStackView = self as? UIStackView {
            let viewToAdd: UIView
            if insets != .zero {
                let wrapperStackView = UIStackView()
                wrapperStackView.isLayoutMarginsRelativeArrangement = true
                wrapperStackView.layoutMargins = insets
                wrapperStackView.addArrangedSubview(subview)
                viewToAdd = wrapperStackView
            } else {
                viewToAdd = subview
            }
            selfStackView.addArrangedSubview(viewToAdd)
        } else {
            addSubview(subview)
        }
        closure(subview)
        return subview
    }
    
    @discardableResult
    public func addFilling<T: UIView>(_ subview: T, insets: UIEdgeInsets = .zero, then closure: ((T) -> Void) = { _ in }) -> T {
        addSubview(subview)
        subview.snapToEdges(insets: insets)
        closure(subview)
        return subview
    }
    
    @discardableResult
    public func addCentering<T: UIView>(_ subview: T, insets: UIEdgeInsets = .zero, then closure: ((T) -> Void) = { _ in }) -> T {
        addSubview(subview)
        subview.positionCenter(insets: insets)
        closure(subview)
        return subview
    }
    
}
