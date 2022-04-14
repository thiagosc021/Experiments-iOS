//
//  ShoppingListTests.swift
//  ShoppingListTests
//
//  Created by Thiago Costa on 4/11/22.
//

import XCTest
@testable import ShoppingList

class ProductModelControllerTests: XCTestCase {
   
    var productModelController = ProductModelController(fileSystem: FileSystemStorageMock())
    
    func testAddNewProductTapped() throws {
        let product = Product(name: "Leite")
        let totalProducts = productModelController.products.count
        
        XCTAssertNoThrow(try productModelController.addProduct(product: product))
        
        XCTAssertFalse(productModelController.products.isEmpty)
        XCTAssertGreaterThan(productModelController.products.count, totalProducts)
    }

    func testRemoveProductTapped() throws {
        let product = Product(name: "Presunto")
        try productModelController.addProduct(product: product)
        let totalProducts = productModelController.products.count
        
        
        XCTAssertNoThrow(try productModelController.deleteProduct(product: product))
        XCTAssertLessThan(productModelController.products.count, totalProducts)
    }
    
    func testProductPurchasedTapped() throws {
        let product = Product(name: "Laranja")
        try productModelController.addProduct(product: product)
        
        XCTAssertNoThrow(try productModelController.togglePurchased(product: product))
                
        let purchasedProduct = productModelController.products[0]
        XCTAssertTrue(purchasedProduct.isPurchased)
    }
    
    func testProductPurchasedCount() throws {
        let prod1 = Product(name: "Laranjas", quantity: 10)
        let prod2 = Product(name: "Bananas", quantity: 3)
        let prod3 = Product(name: "Papel toalha")
        
        try productModelController.addProduct(product: prod1)
        try productModelController.addProduct(product: prod2)
        try productModelController.addProduct(product: prod3)
        
        try productModelController.togglePurchased(product: prod1)
        try productModelController.togglePurchased(product: prod2)
        
        XCTAssertEqual(productModelController.count(purchased: true), 2)
    }
    
    func testProductFetchPurchasedProducts() throws {
        let prod1 = Product(name: "Laranjas", quantity: 10)
        let prod2 = Product(name: "Bananas", quantity: 3)
        let prod3 = Product(name: "Papel toalha")
        
        try productModelController.addProduct(product: prod1)
        try productModelController.addProduct(product: prod2)
        try productModelController.addProduct(product: prod3)
        
        try productModelController.togglePurchased(product: prod1)
        
        XCTAssertEqual(prod1, productModelController.fetchProducts(puschased: true).first)
    }
}
