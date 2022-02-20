//
//  ItemCellModel.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import Foundation

struct ItemCellModel {
    
    enum ViewMode {
        case `default`
        case sold
    }
    
    let item: Item
    let viewMode: ViewMode
    
}
