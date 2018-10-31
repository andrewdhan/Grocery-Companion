//
//  GroceryListTableViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class GroceryListTableViewController: UITableViewController, ItemTableViewCellDelegate, UITextFieldDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        addClearButton.setTitle("Add Item", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)

    }
    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hasCheckedItems = false
        return groceryItemController.groceryList.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        
        let groceryItem = groceryItemController.groceryList[indexPath.row]
        if groceryItem.isChecked && addClearButton.titleLabel?.text == "Add Item" {
            hasCheckedItems = true
            addClearButton.setTitle("Clear ✔️", for: .normal)
        }
        cell.groceryItem = groceryItem
        
        cell.delegate = self
        
        return cell
    }
  
    // IBAction
    @IBAction func addItem(_ sender: Any?) {
        guard inputTextField.isFirstResponder == true,
            let text = inputTextField.text,
            !text.isEmpty else {return}
        
        groceryItemController.addItem(withName: text)
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    @IBAction func clearCheckedItems(_ sender: Any) {
        guard inputTextField.isFirstResponder == false else {return}
        groceryItemController.clearCheckedItems()
        addClearButton.setTitle("Add Item", for: .normal)
        tableView.reloadData()
    }
    //MARK: - UITTextFieldDelegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addClearButton.setTitle("Add Item", for: .normal)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if hasCheckedItems {
        addClearButton.setTitle("Clear ✔️", for: .normal)
        } else {
            addClearButton.setTitle("Add Item", for: .normal)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItem(nil)
        inputTextField.becomeFirstResponder()
        return true
    }
    //MARK: - ItemTableViewCellDelegate Methods
    func toggleCheck(for item: GroceryItem) {
        if inputTextField.isFirstResponder == true{
            inputTextField.resignFirstResponder()
        }
        groceryItemController.checkOffItem(item: item)
        tableView.reloadData()
    }
    
    //MARK: - Private Method
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
    }

    //MARK: - Properties
    private var hasCheckedItems = false
    @IBOutlet weak var addClearButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    private let groceryItemController = GroceryItemController.shared
}
