//
//  ReceiptDetailViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/31/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit
import Vision

private var baseURL = URL(string: "https://vision.googleapis.com/v1/images:annotate")!

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
        
        sendCloudVisionRequest(image: UIImage(named: "test-safeway")!) {
            print("Request reached completion")
        }
    }
    //MARK: - CameraPreviewViewControllerDelegate method
    
    func didFinishProcessingImage(image: UIImage) {
        //        let cgImage = image.cgImage!
        //        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        //
        //        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation, options: [:])
        //
        //        let request = VNDetectTextRectanglesRequest(completionHandler: handleRectangles(request:error:))
        //
        //        DispatchQueue.global(qos: .userInitiated).async {
        //            do {
        //                try imageRequestHandler.perform([request])
        //            } catch let error as NSError {
        //                print("Failed to perform image request: \(error)")
        //                return
        //            }
        //        }
        
    }
    //MARK: - IBActions
    
    @IBAction func addItem(_ sender: Any) {
        //TODO: change for auto population of nearby stores
        guard let storeText = storeTextField.text?.lowercased() else {return}
        self.store = storeText.contains("trader")
            ? StoreController.stores[StoreName.traderJoes.rawValue]
            : StoreController.stores[StoreName.wholeFoods.rawValue]
        
        guard let store = self.store,
            let dateString = dateTextField.text,
            let newItemName = addItemNameField.text,
            let newItemCostString = addItemCostField.text,
            let newItemCost = Double(newItemCostString),
            let date = dateString.toDate(withFormat: .short),
            let transactionID = transactionID else {return}
        
        transactionController.loadItems(name: newItemName, cost: newItemCost, store: store, date: date, transactionID: transactionID)
        addItemCostField.text = ""
        addItemNameField.text = ""
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
        
        let alertController = UIAlertController(title: "Success", message: "Your receipt has been successfully submitted", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.clearViewText()
            self.transactionID = UUID()
        }
        
        alertController.addAction(okAction)
        present(alertController,animated: true, completion: nil)
    }
    private func handleRectangles(request: VNRequest, error: Error?){
        if let error = error {
            NSLog("Error handling request: \(error)")
            return
        }
        
        guard let results = request.results as? [VNTextObservation] else {
            return
        }
        
        print(results.count)
    }
    
    private func resultsToText() -> [DetectedText]{
        return []
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
    
    //MARK: - Networking Functions
    
    //Sends image data to Google Cloud Vision API to perform OCR
    private func sendCloudVisionRequest(image: UIImage, completion:()->Void){
        
        //Use URLComponents to add API Key to base URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        let authenticationItem = URLQueryItem(name: "key", value: GoogleAPIKey)
        
        urlComponents.queryItems = [authenticationItem]
        
        guard let authenticatedURL = urlComponents.url else {
            NSLog("Trouble building url")
            return
            
        }
        
        //Build URL Request
        var request = URLRequest(url: authenticatedURL)
        request.httpMethod = "POST"
        
        //although request.httpBody is optional, we want to make sure that the method did work
        guard let httpBody = buildHTTPBody(image: image) else {
            NSLog("buildHTTPBody failed")
            return
        }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        //Send URLRequest
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with request:\(error)")
                return
            }
            guard let data = data else {
                NSLog("Response data is nil")
                return
            }
            //print data for testing
            print(String(data: data, encoding: String.Encoding.utf8)!)
            //decode data
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(AnnotatedImageResponse.self, from: data)
                self.detectedLines = self.buildLines(with: response)
            } catch{
                NSLog("Error decoding response:\(error)")
                return
            }
            
        }.resume()
    }
    
    //Initializes AnnotatedImageRequest from UIImage and build Json for body of http request
    private func buildHTTPBody(image:UIImage, maxResults:Int? = nil) -> Data?{
        //convert UIImage to base64encodedstring as required for POST
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return nil}
        let imageString = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
        let contentImage = Image(content: imageString)
        
        //set feature to OCR option
        let feature = Feature(type: "DOCUMENT_TEXT_DETECTION",maxResults: 200)
        //create ocrRequest since more than one request can be sent to Cloud Vision
        let ocrRequest = Request(image: contentImage, features: [feature])
        
        //Create AnnotatedImageRequest and encode to json
        let imageRequest = AnnotatedImageRequest(requests: [ocrRequest])
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(imageRequest)
            return data
        } catch {
            NSLog("Error encoding image to json: \(error)")
            return nil
        }
    }
    //MARK: - Private Methods
    private func clearViewText(){
        totalTextField.text = ""
        storeTextField.text = ""
        dateTextField.text = ""
        addItemNameField.text = ""
        addItemCostField.text = ""
        transactionController.clearLoadedItems()
        tableView.reloadData()
    }
    
    //TODO:accepts AnnotatedImageResponse as a parameter and builds detected grocery items as an array of tuples
    private func buildLines(with response: AnnotatedImageResponse)->[(String,Double)]{
        
        return [(String,Double)]()
    }
    
    //TODO:load items from detectedLines to receipt.
    private func loadItems(){
        
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
    
    private var detectedLines: [(String,Double)]?{
        didSet{
            loadItems()
        }
    }
}
