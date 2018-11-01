//
//  ReceiptDetailViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/31/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import Vision

class ReceiptDetailViewController: UIViewController, CameraPreviewViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transactionID = UUID()
        transactionController.clearLoadedItems()
    }
    //MARK: - CameraPreviewViewControllerDelegate method
    
    func didFinishProcessingImage(image: CGImage) {
        //
        //        let requestHandler = image.width > image.height
        //            ? VNImageRequestHandler(cgImage: image, orientation: .right, options: [:])
        //            : VNImageRequestHandler(cgImage: image, options: [:])
        //
        //        let request = VNDetectTextRectanglesRequest { [weak self](request, error) in
        //            DispatchQueue.main.async {
        //                <#code#>
        //            }
        //        }
        //
        
    }
    //MARK: - IBActions
    
    @IBAction func addItem(_ sender: Any) {
        //TODO: change for auto population of nearby stores
        self.store = StoreController.stores[0]
        
        guard let store = self.store,
            let dateString = dateTextField.text,
            let newItemName = addItemNameField.text,
            let newItemCostString = addItemCostField.text,
            let newItemCost = Double(newItemCostString),
            let date = dateString.toDate(withFormat: .short),
            let transactionID = transactionID else {return}
        
        transactionController.loadItems(name: newItemName, cost: newItemCost, store: store, date: date, transactionID: transactionID)
        
        tableView.reloadData()
    }
    
    @IBAction func submitReceipt(_ sender: Any) {
        guard let store = self.store,
            let dateString = dateTextField.text,
            let totalString = totalTextField.text,
            let total = Double(totalString),
            let date = dateString.toDate(withFormat: .short),
            let transactionID = transactionID else {return}
        
        transactionController.create(store: store, date: date, total: total, identifier: transactionID)
    }
    //MARK: - UITableViewDelegate MEthods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionController.loadedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptItemCell", for: indexPath) as! ReceiptItemTableViewCell
        cell.transactionID = transactionID
        cell.groceryItem = transactionController.loadedItems[indexPath.row]
        
        return cell
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScanReceipt" {
            let destinationVC = segue.destination as! CameraPreviewViewController
            destinationVC.delegate = self
        }
    }
    
    //MARK: - Properties
    private var store: Store?
    private var transactionID: UUID?
    
    private let transactionController = TransactionController.shared
    private let groceryItemController = GroceryItemController.shared
    
    @IBOutlet weak var addItemNameField: UITextField!
    @IBOutlet weak var addItemCostField: UITextField!
    
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var storeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
}
