//
//  StoreDetailTableViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class StoreDetailTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        guard isViewLoaded, let store = store else {return}
        self.title = store.name
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 0
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        guard let items = items, let store = store else {return UITableViewCell()}
        let item = items[indexPath.row]
       
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.cheapestPriceForStore(store: store)?.currencyString() ?? "N/A"

        return cell
    }
 

    
    //MARK: - Properties
    var items: [GroceryItem]?
    var store: Store?
    private let groceryItemController = GroceryItemController.shared
}
