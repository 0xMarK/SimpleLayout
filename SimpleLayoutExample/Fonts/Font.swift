//
//  Font.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 22.05.2021.
//

import UIKit

extension UIFont {
    
    static var standard: UIFont { .preferredFont(forTextStyle: .body) }
    static var title: UIFont { .preferredFont(forTextStyle: .title1) }
    static var shortDescription: UIFont { .preferredFont(forTextStyle: .subheadline) }
    static var price: UIFont { .preferredFont(forTextStyle: .body) }
    static var buyButton: UIFont { .preferredFont(forTextStyle: .body) }
    
}
