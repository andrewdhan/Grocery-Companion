//
//  SuggestionsViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        suggestions = storeController.bestStoreToBuyItems(groceryItemController.groceryList)
        tableView.reloadData()
        
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "StoreAnnotation")
        mapView.addAnnotations(suggestions)
    }
    //MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath)
        let store = suggestions[indexPath.row]
        cell.textLabel?.text = store.name
        cell.detailTextLabel?.text = storeController.estimatedCostForGroceries(store: store, items: groceryItemController.groceryList)?.currencyString() ?? "N/A"
        return cell
    }
    //MARK: MapViewDelegate Method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let storeAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: "StoreAnnotation", for: annotation) as! MKMarkerAnnotationView
        storeAnnotation.markerTintColor = .darkGray
        storeAnnotation.glyphTintColor = .white
        
        storeAnnotation.canShowCallout = true
        
        let detailView = StoreDetailView(frame: .zero)
        detailView.store = annotation as? Store
        print(detailView.store)
        
        storeAnnotation.detailCalloutAccessoryView = detailView
        return storeAnnotation
    }
    
    //MARK: - Properties
    let groceryItemController = GroceryItemController.shared
    let storeController = StoreController.shared
    var suggestions = [Store]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
