//
//  ProductListTableViewController.swift
//  ShoppingList
//
//  Created by Thiago Costa on 4/12/22.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    
    private var modelController = ProductModelController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shopping List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try modelController.fetchProductsIfNeeded()
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }

    @IBAction func addProductTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Product", message: "Adds new products to the list", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Product name"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let alert = alert,
                  let textField = alert.textFields?[0],
                  let productName = textField.text else {
                return
            }
            let product = Product(name: productName)
            do {
                try self.modelController.addProduct(product: product)
                self.tableView.reloadData()
            } catch let error {
                print(error)
            }
            
        }))

        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.count(purchased: section != 0)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Not purchased" : "Purchased"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let products = modelController.fetchProducts(puschased: indexPath.section != 0)
        let product = products[indexPath.row]
        
        cell.model = product
        cell.configureUI()
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let products = modelController.fetchProducts(puschased: indexPath.section != 0 )
            let product = products[indexPath.row]
            
            do {
                try modelController.deleteProduct(product: product)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error {
                print(error)
            }
            
        }
    }
   

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "productDetailSegue" ,
            let indexPath = self.tableView.indexPathForSelectedRow,
        let destinationVC = segue.destination as? ProductDetailViewController else {
            return
        }
        
        let products = modelController.fetchProducts(puschased: indexPath.section != 0 )
        let product = products[indexPath.row]
        
        
        destinationVC.model = product
    }

}

extension ProductListTableViewController: ProductTableViewCellDelegate {
    func markAsPurchased(for product: Product) {
        do {
            try modelController.togglePurchased(product: product)
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
}
