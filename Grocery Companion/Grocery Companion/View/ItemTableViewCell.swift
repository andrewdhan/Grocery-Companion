//
//  ItemTableViewCell.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit

protocol ItemTableViewCellDelegate: class{
    func toggleCheck(for item: Item)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBAction func toggleCheckBox(_ sender: Any) {
        guard let groceryItem = groceryItem else {return}
        delegate?.toggleCheck(for: groceryItem)
    }
    
    func updateViews(){
        guard let groceryItem = groceryItem else {return}
        let isChecked = groceryItem.isChecked
        
        if isChecked {
            let attributedText = NSMutableAttributedString(string: groceryItem.name!)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value:2, range: NSMakeRange(0, attributedText.length))
            itemLabel.attributedText = attributedText
        } else {
            itemLabel.attributedText = nil
            itemLabel.text = groceryItem.name
        }
        
        
        
        let checkedStatus = isChecked ? "checked" : "unchecked"
        checkBox.setImage(UIImage(named:checkedStatus), for: .normal)
    }
    
    //MARK: - Properties
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var groceryItem: Item?{
        didSet{
            updateViews()
        }
    }
}
