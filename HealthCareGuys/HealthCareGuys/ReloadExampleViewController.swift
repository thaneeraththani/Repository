//  ReloadExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2016 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import XLPagerTabStrip

class ReloadExampleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
   
    @IBOutlet weak var firstTab: UIButton!
    @IBOutlet weak var secondTab: UIButton!
    @IBOutlet weak var content: UITableView!
    @IBOutlet weak var thirdTab: UIButton!
    var tableViewForFirstTab = UITableView()
    var tableViewForSecondTab = UITableView()
    var tableViewForThirdTab = UITableView()
    
    var tab1: Bool = true
    var tab2:Bool = false
    var tab3:Bool  = false
    var items :[String] = ["head Line 1","Head line 2","Head Line 3"]
    var contItems:[String] = ["contribution 1","Contribution 2","Contribution 3"]
    var shareItems:[String] = ["Share 1","Share 2","Share 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
       tableViewForFirstTab.frame =   CGRectMake(0, 100, view.frame.height, view.frame.width);
        tableViewForSecondTab.frame =  CGRectMake(0, 100, view.frame.height, view.frame.width);
        tableViewForThirdTab.frame =  CGRectMake(0, 100, view.frame.height, view.frame.width);
        tableViewForFirstTab.delegate = self
        tableViewForSecondTab.delegate = self
        tableViewForThirdTab.delegate = self
        tableViewForFirstTab.dataSource = self
        tableViewForSecondTab.dataSource = self
        tableViewForThirdTab.dataSource = self
        tableViewForFirstTab.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")
        tableViewForSecondTab.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")
        tableViewForThirdTab.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")


        tableViewForFirstTab.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewForSecondTab.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableViewForThirdTab.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableViewForFirstTab.backgroundColor = UIColor.cyanColor()
        tableViewForSecondTab.backgroundColor = UIColor.darkGrayColor()
        tableViewForThirdTab.backgroundColor = UIColor.brownColor()
        self.view.addSubview(tableViewForFirstTab)
        menuButton.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)), forControlEvents:UIControlEvents.TouchUpInside)
              self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        rightButton.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.rightRevealToggle(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        firstTab.addTarget(self, action: #selector(ReloadExampleViewController.topNews(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        secondTab.addTarget(self, action: #selector(ReloadExampleViewController.contribution(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        thirdTab.addTarget(self, action: #selector(ReloadExampleViewController.share(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        firstTab.backgroundColor = UIColor.redColor()
        firstTab.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)

    }
    
    func topNews(sender: AnyObject) {
        NSLog("selected")
        tab1 = true
        tab2 = false
        tab3 = false
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        view.reloadInputViews()
        view.addSubview(tableViewForFirstTab)

        setColorForTab(firstTab, sender2: secondTab, sender3: thirdTab)
        
    }
    
 func contribution(sender: AnyObject) {
        tab2 = true
        tab1 = false
        tab3 = false
        
        NSLog("contribution selected")
       
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
    
        self.view.addSubview(tableViewForSecondTab)
       setColorForTab(firstTab, sender2: secondTab, sender3: thirdTab)

        }
   func share(sender: AnyObject) {
        tab3 = true
        tab2 = false
        tab1 = false
       NSLog("share selected")
       view.addSubview(tableViewForThirdTab)
     sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
    setColorForTab(firstTab, sender2: secondTab, sender3: thirdTab)

    
    }
    func setColorForTab(sender: UIButton,sender2: UIButton,sender3 : UIButton) -> Void {
        if tab1 && !tab2 && !tab3{

        sender.backgroundColor =  UIColor.redColor()
            
        sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        sender2.backgroundColor =  UIColor.orangeColor()
            
        sender2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)

        sender3.backgroundColor =  UIColor.orangeColor()
            
        sender3.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
         

        }
        else if !tab1 && tab2 && !tab3{
           
           sender2.backgroundColor =  UIColor.redColor()
            
            sender2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            sender.backgroundColor =  UIColor.orangeColor()
            
            sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            
            sender3.backgroundColor =  UIColor.orangeColor()
            
            sender3.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            

     

        }
        else if !tab1 && !tab2 && tab3{
        sender3.backgroundColor =  UIColor.redColor()
            
        sender3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        sender2.backgroundColor =  UIColor.orangeColor()
            
        sender2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            
        sender.backgroundColor =  UIColor.orangeColor()
            
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            

       

        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tab3{
        return self.shareItems.count
        }
        else if tab2{
            return self.contItems.count
        }
        else{
            return self.items.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("cell")! as! CustomCell
        if tab2{
        cell.heading.text = self.contItems[indexPath.row]
            cell.details.text = "This is a sample news Application for Health Care"
            cell.share.setBackgroundImage(UIImage(named: "share"), forState: UIControlState.Normal)
            cell.backgroundColor = UIColor.darkGrayColor()
        }
        else if tab3{
            cell.details.text = "This is a sample news detail for contribution tab of Health Care Application"
            cell.share.setBackgroundImage(UIImage(named: "share"), forState: UIControlState.Normal)
            cell.heading.text = self.shareItems[indexPath.row]
            cell.backgroundColor = UIColor.brownColor()
        }else{
            cell.details.text = "This is a sample news details for shared tab of Health Care Application"
            cell.share.setBackgroundImage(UIImage(named: "share"), forState: UIControlState.Normal)
           cell.heading.text = self.items[indexPath.row]
            cell.backgroundColor = UIColor.cyanColor()
        }
      
         return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }
