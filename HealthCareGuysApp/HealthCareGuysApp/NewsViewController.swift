//
//  NewsViewController.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 16/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit
import CoreData
class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var list = NSMutableArray()
    
    var conteDetails = NSMutableArray()
    var category = NSMutableArray()
    var urlArray : [String] = []
    var content: [String] = []
    var userDefaults = NSUserDefaults()
    var obLoaderClass = LoaderClass()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        obLoaderClass.login_request()
        print("hii welcome")
        obLoaderClass.getHeadlines_request()
        //list = obLoaderClass.getData()
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        
        list = userDefaults.objectForKey("headlineArray") as! NSMutableArray
        conteDetails = userDefaults.objectForKey("newsContent") as! NSMutableArray
        category = userDefaults.objectForKey("category") as! NSMutableArray
     print("real data\(conteDetails)")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return list.count
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
        cell.headLine.text = list.objectAtIndex(indexPath.section) as? String
         //print("count is \(conteDetails.count)")
        var split = conteDetails.objectAtIndex(indexPath.section) as? String
       // print("splitt\(conteDetails.objectAtIndex(indexPath.section))")
      //  var actualContent = split?.componentsSeparatedByString("<p>")
       // var real = actualContent?.last!.componentsSeparatedByString("</p>")
       // content[indexPath.section] = (actualContent?.last)!
        if indexPath.section == 0{
            var ob :MainCellItems = MainCellItems()
            ob.setCells()
            
        }

        if split!.lowercaseString.rangeOfString("<img src") != nil{
            var arraySplit = split?.componentsSeparatedByString("<img src=\"")
            var address = arraySplit!.last!.componentsSeparatedByString("\">")
            // print("this is\(address[0])")
            var addressString = address[0]
            
            var url = addressString
            //urlArray[indexPath.section] = url
                       //  print("this one\(url)")
            // print("indexPath \(indexPath.section)")
            var imgURL: NSURL = NSURL(string : addressString)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(
                request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                    if error == nil {
                        cell.newsImage.image = UIImage(data: data!)
                    }
            })
        }
        else{
            cell.newsImage.image = UIImage(named: "placeholder")
           // urlArray[indexPath.section] = ""
        }
        if split!.lowercaseString.rangeOfString("source") != nil{
            var arraySplit = split?.componentsSeparatedByString("source:")
            var address = arraySplit!.last!.componentsSeparatedByString("|\n")
            
            cell.commentedTime.text = address.first
        }
        else{
            cell.commentedTime.text = ""
        }
        
        
        
        cell.category.text = category.objectAtIndex(indexPath.section) as! String
        
        userDefaults.setObject(content, forKey:"contentOnly")
        userDefaults.setObject(urlArray, forKey:"urlArray")
        userDefaults.synchronize()
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }
        else{
            return 120
        }
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
       // self.performSegueWithIdentifier("goToView", sender: indexPath)
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


