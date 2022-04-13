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
        
        let prod1 = Product(name: "Laranjas", quantity: 10)
        let prod2 = Product(name: "Bananas", quantity: 3)
        let prod3 = Product(name: "Papel toalha")

        do {
            try modelController.addProduct(product: prod1)
            try modelController.addProduct(product: prod2)
            try modelController.addProduct(product: prod3)
            try modelController.markAsPurschased(product: prod2)
            try modelController.fetchProductsIfNeeded()
        } catch let error {
            print(error)
        }
        
    }

    @IBAction func addProductTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Product", message: "Adds as new product to the list", preferredStyle: .alert)

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
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)           
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductListTableViewController: ProductTableViewCellDelegate {
    func markAsPurchased(for product: Product) {
        do {
            try modelController.markAsPurschased(product: product)
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
}
