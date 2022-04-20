//
//  ProductDetailViewController.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/13/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productNameTextView: UITextField!
    @IBOutlet weak var productQuantityTextView: UITextField!
    @IBOutlet weak var isPurchasedButton: UIButton!
    
    private var modelController = ProductModelController.shared
    
    var model: Product? {
        didSet {
            guard self.isViewLoaded else {
                return
            }
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func purchasedButtonTapped(_ sender: UIButton) {
        guard let model = model else {
            return
        }

        do {
            try modelController.togglePurchased(product: model)
            configureButton()
        } catch let error {
            print(error)
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let model = model,
              let name = productNameTextView.text,
              let quantity = Int(productQuantityTextView.text ?? "0") else {
            return
        }
        
        do {
            try modelController.updateProduct(product: model, name: name, quantity: quantity)
            dismissView()
        } catch let error {
            print(error)
        }
    }
}

private extension ProductDetailViewController {
    
    func dismissView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func configureButton() {
        guard let model = model else {
            return
        }
        let imageName = model.isPurchased ? "checkmark.square" : "square"
        isPurchasedButton.setImage( UIImage(systemName: imageName), for: .normal)
    }
    
    func configureUI() {
        guard let model = model else {
            return
        }

        productNameTextView.text = model.name
        productQuantityTextView.text = "\(model.quantity)"
        configureButton()
    }
}
