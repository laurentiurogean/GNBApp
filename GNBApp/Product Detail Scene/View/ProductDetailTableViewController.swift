//
//  ProductDetailTableViewController.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/17/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {
    var viewModel: ProductDetailViewModel?
    private var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.product
        viewModel?.getSumOfTransactions() { sumOfTransactions in
            self.sum = sumOfTransactions
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactions.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Total sum: \(sum) EUR"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell else {
            fatalError("Unable to dequeue requested ProductDetailTableViewCell")
        }
        
        guard let amount = viewModel?.transactions[indexPath.row].amount,
            let currency = viewModel?.transactions[indexPath.row].currency else {
                return cell
        }
        
        cell.transactionNumberLabel.text = "#\(indexPath.row + 1)"
        cell.amountLabel.text = "\(amount) \(currency)"
        
        return cell
    }
    
}
