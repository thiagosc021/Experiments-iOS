//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/11/22.
//

import Foundation

class Product: Codable, Equatable {
    var name: String
    var quantity: Int
    var isPurchased = false
    
    init(name: String, quantity: Int = 1) {
        self.name = name
        self.quantity = quantity
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.name == rhs.name && lhs.isPurchased == rhs.isPurchased
    }
}



