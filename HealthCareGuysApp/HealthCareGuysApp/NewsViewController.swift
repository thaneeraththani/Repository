//
//  NewsViewController.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 16/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menu: UIButton!
    var list : Dictionary<String,String> = [ : ]
    var headLine = NSMutableArray()
    var category = NSMutableArray()
    var commentTime = NSMutableArray()
    
    var obLoaderClass = LoaderClass()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //  list = obLoaderClass.getData()
        for (key, value) in list {
            print("\(key) -> \(value)")
            
            switch(key){
            case "headLine":
                headLine.addObject(value)
                print(headLine)
                break
            case "id" :
                break
            case "comment" :
                break
            default : print("default")
                break
                
            }
        }
        
        
        
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0)
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MainCellItems = tableView.dequeueReusableCellWithIdentifier("cell") as! MainCellItems
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.layer.cornerRadius = 2
        
        cell.clipsToBounds = true
        // self.performSegueWithIdentifier("goback", sender: indexPath)
        //print("headline array\(headLine)")
        // cell.headLine.text = headLine.objectAtIndex(indexPath.row) as! String
        //cell.category.text = category.objectAtIndex(indexPath.section) as! intptr_t
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
        //self.performSegueWithIdentifier("detailView", sender: indexPath)
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


