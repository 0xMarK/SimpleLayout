//
//  DividerView.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit

open class DividerView: UIView {
    
    open class var defaultInsets: UIEdgeInsets { .zero }
    
    open class var defaultColor: UIColor { .lightGray }
    
    open class var defaultThickness: CGFloat { 1 }
    
    open var insets: UIEdgeInsets {
        didSet {
            contentStackView.layoutMargins = insets
        }
    }
    
    open var color: UIColor? {
        didSet {
            borderView.backgroundColor = color
        }
    }
    
    open var thickness: CGFloat {
        didSet {
            thicknessConstraint?.constant = thickness
        }
    }
    
    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    private var thicknessConstraint: NSLayoutConstraint?
    
    public init(insets: UIEdgeInsets = defaultInsets, color: UIColor? = defaultColor, thickness: CGFloat = defaultThickness) {
        self.insets = insets
        self.color = color
        self.thickness = thickness
        super.init(frame: .zero)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        borderView.constraints.forEach { constraint in
            borderView.removeConstraint(constraint)
        }
        if let stackView = newSuperview as? UIStackView {
            if stackView.axis == .vertical {
                thicknessConstraint = borderView.heightAnchor.constraint(equalToConstant: thickness)
            } else {
                thicknessConstraint = borderView.widthAnchor.constraint(equalToConstant: thickness)
            }
            thicknessConstraint?.isActive = true
        }
    }
    
    private func setupView() {
        addSubview(contentStackView)
        contentStackView.snapToEdges()
        contentStackView.layoutMargins = insets
        contentStackView.addArrangedSubview(borderView)
        borderView.backgroundColor = color
    }
    
}
