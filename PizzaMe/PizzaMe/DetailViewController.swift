//
//  DetailViewController.swift
//  PizzaMe
//
//  Created by Sneha Nemarugomula on 6/23/16.
//  Copyright © 2016 Sneha Nemarugomula. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class DetailView : UIViewController {
    
    var detailDic : NSDictionary = NSDictionary()
    var phoneNumber: String!
    var lattitude: String!
    var langititude: String!
    var user: UserObject! = nil
    
    var detailArr : NSMutableArray = NSMutableArray()


    @IBOutlet weak var tiltleLabel: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tiltleLabel.text = NSString(format: "Title : %@",(detailDic.valueForKey("Title") as? String)!) as String
//        city.text = NSString(format: "City : %@",(detailDic.valueForKey("City") as? String)!) as String
//        address.text = NSString(format: "Address : %@",(detailDic.valueForKey("Address") as? String)!) as String
//        Phone.text = NSString(format: "Phone : %@",(detailDic.valueForKey("Phone") as? String)!) as String
//        state.text = NSString(format: "State : %@",(detailDic.valueForKey("State") as? String)!) as String
//        distance.text = NSString(format: "Disance : %@",(detailDic.valueForKey("Distance") as? String)!) as String
//         lattitude = NSString(format: "Latitude : %@",(detailDic.valueForKey("Latitude") as? String)!) as String
//         langititude = NSString(format: "Longitude : %@",(detailDic.valueForKey("Longitude") as? String)!) as String
        //user = detailArr[0] as! UserObject
        
        tiltleLabel.text = NSString(format: "Title : %@",(user.storeName)!) as String
        city.text = NSString(format: "City : %@",(user.storeCity)!) as String
        address.text = NSString(format: "Address : %@",(user.storeAddress)!) as String
        Phone.text = NSString(format: "Phone : %@",(user.storePhNo)!) as String
        state.text = NSString(format: "State : %@",(user.storeState)!) as String
        distance.text = NSString(format: "Distance : %@",(user.storeDistance)!) as String
        
        lattitude = user.storeLat
        langititude = user.storeLong
        phoneNumber = user.storePhNo
        
        
    }
    
    
    
    @IBAction func showOnMapsBtnClicked(sender: AnyObject) {
        
        
        let lat1 : NSString = self.lattitude
        let lng1 : NSString = self.langititude
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.tiltleLabel.text)"
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
    @IBAction func callToPhoneNumberBtnClicked(sender: AnyObject) {
        
        let formatedNumber = phoneNumber.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        let phoneUrl = "tel://\(formatedNumber)"
        let url:NSURL = NSURL(string: phoneUrl)!
        UIApplication.sharedApplication().openURL(url)


    }
    @IBAction func backButtonClicked(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(,).:!_".characters)
        
        let temp = String(text.characters.filter{okayChars.contains($0)})
        
        print(temp)
        
        return String(text.characters.filter {okayChars.contains($0) })
    }
}