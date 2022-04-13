//
//  ProductTableViewCell.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/12/22.
//

import UIKit

protocol ProductTableViewCellDelegate {
    func markAsPurchased(for product: Product)
}

class ProductTableViewCell: UITableViewCell {

    var model: Product?
    var delegate: ProductTableViewCellDelegate?
    
    @IBOutlet weak var isPurchasedButton: UIButton!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        guard let model = model else {
            return
        }

        let imageName = model.isPurchased ? "checkmark.square" : "square"
        
        productDescriptionLabel.text = "\(model.quantity) - \(model.name)"
        isPurchasedButton.setImage( UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func purchasedButtonTapped(_ sender: Any) {
        guard let model = model else {
            return
        }

        delegate?.markAsPurchased(for: model)
    }
}
