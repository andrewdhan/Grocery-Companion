//
//  GroceryListTableViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class GroceryListTableViewController: UITableViewController, ItemTableViewCellDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItemController.groceryList.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        
        cell.groceryItem = groceryItemController.groceryList[indexPath.row]
        cell.delegate = self
        
        return cell
    }
  
    // IBAction
    @IBAction func addItem(_ sender: Any) {
        guard let text = inputTextField.text, !text.isEmpty else {return}
        groceryItemController.addItem(withName: text)
        tableView.reloadData()
    }
    
    //MARK: - ItemTableViewCellDelegate Methods
    func toggleCheck(for item: GroceryItem) {
        groceryItemController.checkOffItem(item: item)
        tableView.reloadData()
    }

    //MARK: - Properties
    @IBOutlet weak var inputTextField: UITextField!
    let groceryItemController = GroceryItemController.shared
}
