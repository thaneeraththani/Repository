//
//  MenuViewController.swift
//  MenuSample
//
//  Created by Thaneerath on 30/08/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{

    var data = ["Home","News","Contribution","Favourites","Favourites"]
    var filter = []
          override func viewDidLoad() {
        super.viewDidLoad()
     
    }
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.revealViewController().frontViewController.view.userInteractionEnabled = false
     self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
       self.revealViewController().frontViewController.view.userInteractionEnabled = true
    }
    

}
