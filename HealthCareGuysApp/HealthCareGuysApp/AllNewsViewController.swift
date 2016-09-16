//
//  AllNewsViewController.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 16/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class AllNewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0)
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("cellAllNews") as! CustomCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.layer.cornerRadius = 2
       
        cell.clipsToBounds = true
        

        return cell
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        self.performSegueWithIdentifier("detailView", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }
    


}
