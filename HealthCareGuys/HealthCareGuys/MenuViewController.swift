//
//  MenuViewController.swift
//  MenuSample
//
//  Created by Thaneerath on 30/08/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController,UISearchBarDelegate{
  
  
    @IBOutlet weak var searchItem: UISearchBar!
    var data = ["First Item","Second Item","Third Item"]
    var filter = []
          override func viewDidLoad() {
        super.viewDidLoad()
      searchItem.delegate = self
            var searchText:String = searchItem.text!
            if data.contains(searchText){
                        }

    }
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
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
