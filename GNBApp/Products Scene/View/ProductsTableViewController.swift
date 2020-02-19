//
//  ViewController.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    var viewModel = ProductsViewModel()
    private var selectedProduct = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getTransactions() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.getRates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.products?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedProduct = viewModel.products?[indexPath.row] {
            self.selectedProduct = selectedProduct
            performSegue(withIdentifier: "ProductDetailSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetailSegue" {
            if let destination = segue.destination as? ProductDetailTableViewController,
                let transactions = viewModel.transactions,
                let rates = viewModel.rates{
                destination.viewModel = ProductDetailViewModel(product: selectedProduct, transactions: transactions, rates: rates)
            }
        }
    }
}
