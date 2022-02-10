//
//  CoinListTableViewController.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import UIKit

class CoinListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinController.fetchCoins { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinController.coins.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        let coin = CoinController.coins[indexPath.row]
        // Create the "custom" configuration
        var coinCellConfiguration = cell.defaultContentConfiguration()
        // Set the values
        coinCellConfiguration.text = coin.name
        coinCellConfiguration.secondaryText = "Symbol: \(coin.symbol), id: \(coin.id)"
        // Set the configuration
        cell.contentConfiguration = coinCellConfiguration

        return cell
    }
}
