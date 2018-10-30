//
//  ItemTableViewCell.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

protocol ItemTableViewCellDelegate: class{
    func toggleCheck(for item: GroceryItem)
}

class ItemTableViewCell: UITableViewCell {

    @IBAction func toggleCheckBox(_ sender: Any) {
        guard let groceryItem = groceryItem else {return}
//        groceryItem.isChecked = !groceryItem.isChecked
//        let checkedStatus = groceryItem.isChecked ? "checked" : "unchecked"
//        checkBox.imageView?.image = UIImage(named: checkedStatus)
//        
        delegate?.toggleCheck(for: groceryItem)
    }
    
    func updateViews(){
        guard let groceryItem = groceryItem else {return}
        itemLabel.text = groceryItem.name
        let checkedStatus = groceryItem.isChecked ? "checked" : "unchecked"
        checkBox.imageView?.image = UIImage(named: checkedStatus)
    }
    
    //MARK: - Properties
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var groceryItem: GroceryItem?{
        didSet{
            updateViews()
        }
    }
}
