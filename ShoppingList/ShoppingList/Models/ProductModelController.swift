//
//  ProductModelController.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/11/22.
//

import Foundation

enum ProductModelError: Error {
    case ProductNotFound
    case ProductNameIsRequired
}

class ProductModelController {
    var products: [Product] = []
    var fileSystem: FileSystemStorageProtocol
    static let fileName = "shoppingList.json"
    static var shared = ProductModelController(fileSystem: FileSystemStorage(fileName: fileName))
    
    init(fileSystem: FileSystemStorageProtocol) {
        self.fileSystem = fileSystem
    }
    
    func fetchProductsIfNeeded() throws {
        if products.isEmpty {
            products = try fileSystem.loadFromPersistentStorage([Product].self)
        }
    }
    
    func addProduct(product: Product) throws {
        guard !product.name.isEmpty else {
            throw ProductModelError.ProductNameIsRequired
        }
        
        products.append(product)
        try fileSystem.saveToPersistentStorage(content: products)
    }
    
    func updateProduct(product: Product, name: String, quantity: Int) throws {
        guard let currentProduct = products.first(where: { $0 == product }) else {
            throw ProductModelError.ProductNotFound
        }
        
        currentProduct.name = name
        currentProduct.quantity = quantity
        try fileSystem.saveToPersistentStorage(content: products)
    }
    
    func deleteProduct(product: Product) throws {
        products.removeAll(where: {$0 == product})
        try fileSystem.saveToPersistentStorage(content: products)
    }
    
    func togglePurchased(product: Product) throws {
        guard let purchasedProduct = products.first(where: { $0 == product }) else {
            throw ProductModelError.ProductNotFound
        }
        
        purchasedProduct.isPurchased.toggle()
        try fileSystem.saveToPersistentStorage(content: products)
    }
    
    func count(purchased: Bool) -> Int {
        return products.filter({ $0.isPurchased == purchased}).count
    }
    
    func fetchProducts(puschased: Bool) -> [Product] {
        return products.filter( { $0.isPurchased == puschased })
    }
}
