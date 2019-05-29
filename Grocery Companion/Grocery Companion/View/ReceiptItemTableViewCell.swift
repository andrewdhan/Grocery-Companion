//
//  ReceiptItemTableViewCell.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/31/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit

class ReceiptItemTableViewCell: UITableViewCell {

    func updateViews(){
        guard let groceryItem = groceryItem,
            let name = groceryItem.name,
        let itemHistory = itemHistory,
        let price = itemHistory[name] else {return}
        
        nameLabel.text = groceryItem.name
        costLabel.text = price.centValueToDollarString()
    }
    var groceryItem: Item? {
        didSet{
            updateViews()
        }
    }
    
    var transactionID: UUID?
    var itemHistory: [ String: Int]?
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var costLabel: UITextField!
}
