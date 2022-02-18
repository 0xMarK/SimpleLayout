//
//  String+rect.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit

extension String {
    
    func rect(with size: CGSize, font: UIFont? = nil) -> CGRect {
        let attributes: [NSAttributedString.Key: Any]?
        if let font = font {
            attributes = [.font: font]
        } else {
            attributes =  nil
        }
        return self.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil)
    }
    
}
