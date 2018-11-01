//
//  SuggestionsViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        suggestions = storeController.bestStoreToBuyItems(groceryItemController.groceryList)

        tableView.reloadData()
    }
    //MARK: UITableViewDataSource Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath)
        cell.textLabel?.text = suggestions[indexPath.row].name
        return cell
    }
    
    
    //MARK: - Properties
    let groceryItemController = GroceryItemController.shared
    let storeController = StoreController.shared
    var suggestions = [Store]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
