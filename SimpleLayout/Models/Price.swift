//
//  Price.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import Foundation

struct Price: Codable, Equatable {
    
    let basePrice: Decimal
    let tax: Decimal?
    let currency: String
    let amountToPay: Decimal
    
}
