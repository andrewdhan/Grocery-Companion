//
//  GroceryListTableViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit
import CoreData

class GroceryListTableViewController: UITableViewController, ItemTableViewCellDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        addClearButton.setTitle("Add Item", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)

    }
    
    // MARK: - NSFetchedResultsControllerDelegate methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        //decides what to do when section is changed, i.e. deleted or added item will affect the sections displayed
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer:sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    
    //decides what to do when objects are changed
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            //if object is inserted then we need to tell tableView to insert a row
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            //if object is deleted then we need to tell tableView to delete old indexPath
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            //if object needs to be updated then we need to tell tableView to reload the rows
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            //if object needs to be moved then we need to tell tableView to delete old row and insert new row.
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    // MARK: - Table view data source
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sections?[section].name
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        cell.groceryItem = fetchedResultsController.object(at: indexPath)
        
        return cell
    }
    
    // IBAction
    @IBAction func addItem(_ sender: Any?) {
        guard inputTextField.isFirstResponder,
            let text = inputTextField.text,
            !text.isEmpty else {return}
        
        groceryItemController.addItem(name: text, addToList: true)
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    @IBAction func clearCheckedItems(_ sender: Any) {
//        guard !inputTextField.isFirstResponder else {return}
//
//        GroceryItemController.clearCheckedItems()
//        addClearButton.setTitle("Add Item", for: .normal)
//        tableView.reloadData()
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
        addClearButton.setTitle("Add Item", for: .normal)
        return true
    }
    //MARK: - ItemTableViewCellDelegate Methods
    func toggleCheck(for item: Item) {
        if inputTextField.isFirstResponder{
            inputTextField.resignFirstResponder()
        }
        groceryItemController.checkOffItem(item: item)
        tableView.reloadData()
    }
    
    //MARK: - Private Method
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if inputTextField.isFirstResponder{
        inputTextField.resignFirstResponder()
        }
    }

    //MARK: - Properties
    private var hasCheckedItems = false
    @IBOutlet weak var addClearButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    private let groceryItemController = GroceryItemController.shared
    
    lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "isInList == YES")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: "isChecked", //tells NSFRC to section by mood
            cacheName: nil)
        frc.delegate = self
        try! frc.performFetch() //There should be no issues with perform fetch. If there is then something seriously bad went wrong
        return frc
    }()
}
