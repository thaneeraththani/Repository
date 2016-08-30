//
//  MenuViewController.swift
//  MenuSample
//
//  Created by Thaneerath on 30/08/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{
  
    var itemArray:[String] = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
              itemArray.append("First Item")
              itemArray.append("Second Item")
              itemArray.append("Third Item")
              itemArray.append("Fourth Item")
       
    
    }
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
}
