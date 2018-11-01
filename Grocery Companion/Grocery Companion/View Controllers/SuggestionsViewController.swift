//
//  SuggestionsViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
