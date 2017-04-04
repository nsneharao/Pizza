//
//  PizzaLocationsListViewController.swift
//  PizzaMe
//
//  Created by Sneha Nemarugomula on 6/23/16.
//  Copyright © 2016 Sneha Nemarugomula. All rights reserved.
//

import UIKit

class PizzaLocationsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var finalArray: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pizza.jpg")!)
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true;
        
       // self.addDummyData()
        
    }
//    func addDummyData() {
//        RestApiManager.sharedInstance.getRandomUser { (json: JSON) in
//            if let query = json["query"].dictionary {
//                
//                let results = query["results"]!.dictionary
//                
//                let shops = results!["Result"]!.object
//                
//                let tempArray = NSMutableArray()
//                tempArray.addObject(shops)
//                
//                self.finalArray = tempArray.objectAtIndex(0) as! NSMutableArray
//                
//                dispatch_async(dispatch_get_main_queue(),{
//                    self.tableView!.reloadData()
//                })
//            }
//        }
//    }
    
    
    // MARK : - TableViewDelegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(finalArray.count>0)
        {
            return self.finalArray.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",
                                                               forIndexPath: indexPath)
       // cell.backgroundColor = UIColor.clearColor()
        print(self.finalArray)
        let user:UserObject =  self.finalArray[indexPath.row] as! UserObject

        
//        let title  = self.finalArray.objectAtIndex(indexPath.row).valueForKey("Title")!
//        let address = self.finalArray.objectAtIndex(indexPath.row).valueForKey("Address")!
//        let phone = self.finalArray.objectAtIndex(indexPath.row).valueForKey("Phone")!
//        let distance = self.finalArray.objectAtIndex(indexPath.row).valueForKey("Distance")!
        
        let title  = user.storeName
        let address = user.storeAddress
        let phone = user.storePhNo
        let distance = user.storeDistance

    
        
        cell.textLabel?.text = "Title : \(title) \nAddress : \(address) \nTelephone : \(phone) \ndistance : \(distance)"
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewContrler = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as? DetailView
        detailViewContrler!.user = self.finalArray.objectAtIndex(indexPath.row) as! UserObject
        self.navigationController?.pushViewController(detailViewContrler!, animated: true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func backButtonClicked(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
