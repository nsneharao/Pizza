//
//  RestApiManager.swift
//  PizzaMe
//
//  Created by Sneha Nemarugomula on 6/23/16.
//  Copyright © 2016 Sneha Nemarugomula. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    var zipCodeStr: NSString!
    //let baseURL = "http://api.randomuser.me/"
    
    let baseURL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D'"
    let query = "'%20and%20query%3D'pizza'&format=json&diagnostics=true&callback="
    
    func getNearestStores(onCompletion: (JSON) -> Void  ) {

       // print(self.zipCodeStr)
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    // MARK: Perform a GET Request
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        //zipCodeStr = "94085"
        let requestUrl = NSString(format: "%@%@%@",baseURL,zipCodeStr,query) as String
        let request = NSMutableURLRequest(URL: NSURL(string: requestUrl)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
                
                print(json)
                
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
    // MARK: Perform a POST Request
    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            request.HTTPBody = jsonBody
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
        }
    }
}