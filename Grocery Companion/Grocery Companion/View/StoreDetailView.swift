////
////  StoreDetailView.swift
////  Grocery Companion
////
////  Created by Andrew Dhan on 11/1/18.
////  Copyright © 2018 Andrew Dhan. All rights reserved.
////
//
//import UIKit
//
//class StoreDetailView: UIView {
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }
//    override init(frame: CGRect) {
//        super.init(frame:frame)
//        
//        
//        let stackView = UIStackView(arrangedSubviews: [estimatedCostLabel,itemLabel])
//        stackView.spacing = UIStackView.spacingUseSystem
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(stackView)
//        stackView.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        
//        
//    }
//    //MARK: - Private Method
//    private func updateSubviews(){
//        guard let store = store else {return}
//        estimatedCostLabel.text = storeController.estimatedCostForGroceries(store: store, items: groceryItemController.groceryList)?.currencyString()
//    }
//    
//    //MARK: - Properties
//    var store: Store?{
//        didSet{
//            updateSubviews()
//        }
//    }
//    
//    private let itemLabel = UILabel()
//    private let estimatedCostLabel = UILabel()
//    private let storeController = StoreController.shared
//    private let groceryItemController = GroceryItemController.shared
//}
