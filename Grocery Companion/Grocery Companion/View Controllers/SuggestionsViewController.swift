//
//  SuggestionsViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        guard let avgCoordinate =  storeController.averageStoreCoordinate() else {return}
        let viewRegion = MKCoordinateRegion(center: avgCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(viewRegion, animated: false)
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
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            NSLog("Empty location array")
            return
        }
        self.location = location.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error getting location: \(error)")
    }
    
    //MARK: MapViewDelegate Method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let storeAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: "StoreAnnotation", for: annotation) as! MKMarkerAnnotationView
        storeAnnotation.markerTintColor = .darkGray
        storeAnnotation.glyphTintColor = .white
        
        storeAnnotation.canShowCallout = true
        
        let detailView = StoreDetailView(frame: .zero)
        detailView.store = annotation as? Store
        
        storeAnnotation.detailCalloutAccessoryView = detailView
        return storeAnnotation
    }
    
    //MARK: - Private
    func updateMapRegion(){
        //Zoom to user location
        guard let location = location else {return}
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(viewRegion, animated: true)
        
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails"{
            let destinationVC = segue.destination as! StoreDetailTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            destinationVC.items = groceryItemController.groceryList
            destinationVC.store = suggestions[index]
            
        }
    }
    //MARK: - Properties
    private var locationManager  = CLLocationManager()
    private var location: CLLocationCoordinate2D? {
        didSet{
            updateMapRegion()
        }
    }
    
    let groceryItemController = GroceryItemController.shared
    let storeController = StoreController.shared
    var suggestions = [Store]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
