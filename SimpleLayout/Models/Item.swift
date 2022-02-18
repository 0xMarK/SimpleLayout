//
//  Item.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit

struct Item: Equatable {
    
    let id: String
    let name: String
    let image: UIImage?
    let shortDescription: String?
    let description: String?
    let price: Price
    
}

extension Item {
    
    static let compactItem: Item = Item(
        id: UUID().uuidString,
        name: "Headphones",
        image: UIImage(named: "Headphones"),
        shortDescription: "High quality headphones. The best for your ears!",
        description: nil,
        price: Price(basePrice: 230, tax: 30, currency: "USD", amountToPay: 260)
    )
    
    static let fullItem: Item = Item(
        id: UUID().uuidString,
        name: "Headphones",
        image: UIImage(named: "Headphones"),
        shortDescription: "High quality headphones. The best for your ears!",
        description: "High quality headphones. The best for your ears!\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus auctor gravida velit, et ornare erat commodo id. Mauris pretium, nunc non placerat egestas, mi augue egestas lorem, sed finibus augue diam ut nunc. Aliquam venenatis semper interdum. Nulla facilisi. Aenean lacinia ex lectus, vel porttitor risus rutrum eu. Donec suscipit libero nec tincidunt pellentesque. Nulla facilisi. Vivamus eget pulvinar est. Nullam risus felis, fringilla sit amet dui non, malesuada luctus elit. Etiam molestie fermentum diam sed mollis. Nunc dignissim gravida nunc, non fermentum felis mollis eu. Ut sodales fringilla turpis nec feugiat. Aliquam id dolor fringilla, egestas enim nec, aliquam dui.",
        price: Price(basePrice: 230, tax: 30, currency: "USD", amountToPay: 260)
    )
    
    static let items: [Item] = [
        fullItem,
        Item(
            id: UUID().uuidString,
            name: "Key",
            image: UIImage(named: "Key"),
            shortDescription: "The ultimate tool for a master at home.",
            description: "The ultimate tool for a master at home.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus auctor gravida velit, et ornare erat commodo id. Mauris pretium, nunc non placerat egestas, mi augue egestas lorem, sed finibus augue diam ut nunc. Aliquam venenatis semper interdum. Nulla facilisi. Aenean lacinia ex lectus, vel porttitor risus rutrum eu. Donec suscipit libero nec tincidunt pellentesque. Nulla facilisi. Vivamus eget pulvinar est. Nullam risus felis, fringilla sit amet dui non, malesuada luctus elit. Etiam molestie fermentum diam sed mollis. Nunc dignissim gravida nunc, non fermentum felis mollis eu. Ut sodales fringilla turpis nec feugiat. Aliquam id dolor fringilla, egestas enim nec, aliquam dui.",
            price: Price(basePrice: 20, tax: 2, currency: "USD", amountToPay: 22)
        ),
        Item(
            id: UUID().uuidString,
            name: "Sander",
            image: UIImage(named: "Sander"),
            shortDescription: "Everybody needs a sander.",
            description: "Everybody needs a sander.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus auctor gravida velit, et ornare erat commodo id. Mauris pretium, nunc non placerat egestas, mi augue egestas lorem, sed finibus augue diam ut nunc. Aliquam venenatis semper interdum. Nulla facilisi. Aenean lacinia ex lectus, vel porttitor risus rutrum eu. Donec suscipit libero nec tincidunt pellentesque. Nulla facilisi. Vivamus eget pulvinar est. Nullam risus felis, fringilla sit amet dui non, malesuada luctus elit. Etiam molestie fermentum diam sed mollis. Nunc dignissim gravida nunc, non fermentum felis mollis eu. Ut sodales fringilla turpis nec feugiat. Aliquam id dolor fringilla, egestas enim nec, aliquam dui.",
            price: Price(basePrice: 20, tax: 2, currency: "USD", amountToPay: 22)
        ),
        Item(
            id: UUID().uuidString,
            name: "Jar",
            image: UIImage(named: "Jar"),
            shortDescription: "The jar with some ointment.",
            description: "The jar with some ointment.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus auctor gravida velit, et ornare erat commodo id. Mauris pretium, nunc non placerat egestas, mi augue egestas lorem, sed finibus augue diam ut nunc. Aliquam venenatis semper interdum. Nulla facilisi. Aenean lacinia ex lectus, vel porttitor risus rutrum eu. Donec suscipit libero nec tincidunt pellentesque. Nulla facilisi. Vivamus eget pulvinar est. Nullam risus felis, fringilla sit amet dui non, malesuada luctus elit. Etiam molestie fermentum diam sed mollis. Nunc dignissim gravida nunc, non fermentum felis mollis eu. Ut sodales fringilla turpis nec feugiat. Aliquam id dolor fringilla, egestas enim nec, aliquam dui.",
            price: Price(basePrice: 35, tax: 3.50, currency: "USD", amountToPay: 38.5)
        ),
        Item(
            id: UUID().uuidString,
            name: "Dice",
            image: UIImage(named: "Dice"),
            shortDescription: "Red dice cube with white dots.",
            description: "Red dice cube with white dots.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus auctor gravida velit, et ornare erat commodo id. Mauris pretium, nunc non placerat egestas, mi augue egestas lorem, sed finibus augue diam ut nunc. Aliquam venenatis semper interdum. Nulla facilisi. Aenean lacinia ex lectus, vel porttitor risus rutrum eu. Donec suscipit libero nec tincidunt pellentesque. Nulla facilisi. Vivamus eget pulvinar est. Nullam risus felis, fringilla sit amet dui non, malesuada luctus elit. Etiam molestie fermentum diam sed mollis. Nunc dignissim gravida nunc, non fermentum felis mollis eu. Ut sodales fringilla turpis nec feugiat. Aliquam id dolor fringilla, egestas enim nec, aliquam dui.",
            price: Price(basePrice: 2, tax: 0.50, currency: "USD", amountToPay: 2.5)
        ),
        Item(
            id: UUID().uuidString,
            name: "Car",
            image: nil,
            shortDescription: "Somebody wants a car?",
            description: "Somebody wants a car?",
            price: Price(basePrice: 20, tax: 2, currency: "USD", amountToPay: 22)
        ),
        Item(
            id: UUID().uuidString, name: "Motorcycle",
            image: nil,
            shortDescription: nil,
            description: nil,
            price: Price(basePrice: 35, tax: 3.50, currency: "USD", amountToPay: 38.5)
        )
    ]
    
}
