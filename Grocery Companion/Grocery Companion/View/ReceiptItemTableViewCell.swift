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
            let transactionID = transactionID else {return}
        nameLabel.text = groceryItem.name
        costLabel.text = groceryItem.getPriceWithID(transactionID: transactionID)?.value.currencyString()
    }
    var groceryItem: GroceryItem? {
        didSet{
            updateViews()
        }
    }
    
    var transactionID: UUID?
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var costLabel: UITextField!
}
