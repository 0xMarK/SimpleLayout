//
//  HStackView.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 23.12.2022.
//

import UIKit

open class HStackView: UIStackView {
    
    public init(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, insets: UIEdgeInsets = .zero) {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.alignment = alignment
        self.spacing = spacing
        if insets != .zero {
            self.isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = insets
        }
    }
    
    public required init(coder: NSCoder) {
        fatalError()
    }
    
}
