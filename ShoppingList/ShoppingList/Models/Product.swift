//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/11/22.
//

import Foundation

class Product: Codable, Equatable {
    var name: String
    var isPurchased = false
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.name == rhs.name && lhs.isPurchased == rhs.isPurchased
    }
}



