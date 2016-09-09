//
//  MasterViewController.swift
//  SplitSample
//
//  Created by Thaneerath on 08/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class MasterViewController:UITableViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        // Configure the cell...
        
        return cell
    }

}
