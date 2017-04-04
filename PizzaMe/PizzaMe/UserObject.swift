//
//  UserObject.swift
//  PizzaMe
//
//  Created by Sneha Nemarugomula on 6/23/16.
//  Copyright © 2016 Sneha Nemarugomula. All rights reserved.
//


import SwiftyJSON

class UserObject {
    var storeAddress: String!
    var storeName: String!
    var storeCity: String!
    var storePhNo: String!
    var storeDistance: String!
    var storeState: String!
    var storeLat: String!
    var storeLong: String!

    

    var stroresArray = NSMutableArray()
    var tempArray = NSMutableArray()


    
    required init(json: NSMutableDictionary) {
        
//        let query = json["query"].dictionary
//        let results = query!["results"]!.dictionary
//        let shops = results!["Result"]!.object
//        self.arrPizzaStores.addObject(shops)
      //  self.stroresArray = json.objectAtIndex(0) as! NSMutableArray

        
//        for strArr in self.stroresArray
//        {

            storeName = json.valueForKey("Title") as? String
            storeCity = json.valueForKey("City") as? String
            storePhNo = json.valueForKey("Phone") as? String
            storeAddress = json.valueForKey("Address") as? String
            storeDistance = json.valueForKey("Distance") as? String
            storeState = json.valueForKey("State") as? String
            storeLat = json.valueForKey("Latitude") as? String
            storeLong = json.valueForKey("Longitude") as? String

            
            
         //   self.tempArray.addObject(self)
    //    }

    }
}