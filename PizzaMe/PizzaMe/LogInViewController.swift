//
//  LogInViewController.swift
//  PizzaMe
//
//  Created by Sneha Nemarugomula on 6/23/16.
//  Copyright © 2016 Sneha Nemarugomula. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class LogInViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var zipTextfield: UITextField!
    
    var items = [UserObject]()
    var locationManager:CLLocationManager!
    var locationZip: String!
    var testArray = NSMutableArray()
    var stroresArray = NSMutableArray()
    var finalArray = NSMutableArray()



    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = UIColor.blueColor()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true;
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            
            locationManager.requestAlwaysAuthorization()
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBarHidden = true;
        
        testArray = NSMutableArray()
        stroresArray = NSMutableArray()
        finalArray = NSMutableArray()
        
        //self.jsonParser()

    }
    
    func callForCurrentLocationZipCode()  {
        
        locationManager.startUpdatingLocation()

        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // This only works when user location is updated.
        
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude as Double
        let lat = userLocation.coordinate.latitude as Double
        print(long)
        print(lat)
        
        let longitude = "\(long)"
        let latitude = "\(lat)"


        if latitude.isEmpty == false && longitude.isEmpty == false {
            
            self.setUsersClosestCity(lat, longitude: long)
            self.locationManager.stopUpdatingLocation()

        }
        
    }
    
    func setUsersClosestCity(lattitude: Double, longitude: Double)
    {
        self.locationManager.stopUpdatingLocation()

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lattitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in
            

            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                self.locationZip = zip as String
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }
            
            
            RestApiManager.sharedInstance.zipCodeStr = self.locationZip as String

            
            self.getPizzaStoresDataWithZipCode(self.locationZip)
            

        }
        

        // return self.locationZip
        
        
    }
    
    
    func getPizzaStoresDataWithZipCode(zipCode : String) {
        
        RestApiManager.sharedInstance.getNearestStores {(json: JSON) in
            
        
        
            if let query = json["query"].dictionary {
                let results = query["results"]!.dictionary
                if results != nil {
                    //Do Something
                    let shops = results!["Result"]!.object
                    self.testArray.addObject(shops)
                    self.stroresArray = self.testArray.objectAtIndex(0) as! NSMutableArray
                    for strArr in self.stroresArray
                    {
                        let userObj : UserObject  = UserObject (json: strArr as! NSMutableDictionary)
                        self.finalArray.addObject(userObj)


                    }
                    
                    
                    print(self.finalArray)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        let pizzaStoreListControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("PizzaLocationsListViewController") as? PizzaLocationsListViewController
                        pizzaStoreListControllerObj?.finalArray = self.finalArray
                        self.navigationController?.pushViewController(pizzaStoreListControllerObj!, animated: true)
                        
                    })

                }
                else{
                    
                    let alert = UIAlertController(title: "Alert", message: "No store Found Please enter ZipCode to Search manually", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                    

                
                }
            }
        }
    }

    
    // MARK: - Custom Methods

    @IBAction func findNearestPizaButtonClicked(sender: AnyObject) {
        zipTextfield.resignFirstResponder()

        
        if zipTextfield.text!.isEmpty {
            self.callForCurrentLocationZipCode()
        }
        else{
            let zipCode = zipTextfield.text! as String
            RestApiManager.sharedInstance.zipCodeStr = zipCode as String

            self.getPizzaStoresDataWithZipCode(zipCode)
        }


//        self.locationZip = ""
//        
//        self.getPizzaStoresDataWithZipCode(self.locationZip)

        
        
     
    }
    // MARK: Text field delegate Methods
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
}
