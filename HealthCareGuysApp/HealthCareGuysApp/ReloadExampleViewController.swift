//  ReloadExampleViewController.swift


import UIKit
import CoreData

class MyCell:UITableViewCell{
    
    var headLine:UILabel!
    var commentedTime:UILabel!
    var newsImage:UIImageView!
    var share:UIButton!
    var exit: UIButton!
    var bookmark: UIButton!
    var separatorBar: UIView!
    func setupCell() -> Void {
        headLine = UILabel(frame: CGRectMake(94, -20, contentView.frame.width - 20, 100))
        commentedTime = UILabel(frame: CGRectMake(94, 57, 218, 21))
        newsImage = UIImageView(frame: CGRectMake(8, 8, 50, 50))
        separatorBar = UIView(frame: CGRectMake(0, 90, 600, 1))
        share = UIButton(frame: CGRectMake(19, 102, 24, 24))
        exit = UIButton(frame: CGRectMake(350, 102, 24, 24))
        bookmark = UIButton(frame: CGRectMake(94, 102, 24, 24))
        separatorBar.backgroundColor = UIColor.grayColor()
        commentedTime.textColor = UIColor.grayColor()
        commentedTime.font.fontWithSize(13)
        headLine.font = UIFont.boldSystemFontOfSize(15)
        
        headLine.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headLine.numberOfLines = 2
        self.contentView.addSubview(headLine)
        self.contentView.addSubview(commentedTime)
        self.contentView.addSubview(newsImage)
        self.contentView.addSubview(separatorBar)
        self.contentView.addSubview(exit)
        self.contentView.addSubview(share)
        self.contentView.addSubview(bookmark)
    }
    
    
}


class ReloadExampleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var contributionView: UIView!
    @IBOutlet weak var topNewsView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var firstTab: UIButton!
    @IBOutlet weak var secondTab: UIButton!
    @IBOutlet weak var content: UITableView!
    @IBOutlet weak var thirdTab: UIButton!
    var tableViewForFirstTab = UITableView()
    var tableViewForSecondTab = UITableView()
    var tableViewForThirdTab = UITableView()
    var obLoaderClass:LoaderClass = LoaderClass()
    var tab1: Bool = true
    var result:NSURLResponse?
    var tab2:Bool = false
    var tab3:Bool  = false
    var fetchData = [NSManagedObject]()
    var detailsArray: Array<HeadLines> = []
    var items :[String] = ["head Line 1","Head line 2","Head Line 3"]
    var contItems:[String] = ["contribution 1","Contribution 2","Contribution 3"]
    var shareItems:[String] = ["Share 1","Share 2","Share 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        topNewsView.hidden = false
        contributionView.hidden = true
        shareView.hidden = true
        
        tableViewForFirstTab.frame =   CGRectMake(10, 105, view.frame.width - 20, view.frame.height);
        tableViewForSecondTab.frame =  CGRectMake(10, 105, view.frame.width - 20, view.frame.height);
        tableViewForThirdTab.frame =  CGRectMake(10, 105, view.frame.width - 20, view.frame.height);
        tableViewForFirstTab.delegate = self
        tableViewForSecondTab.delegate = self
        tableViewForThirdTab.delegate = self
        tableViewForFirstTab.dataSource = self
        tableViewForSecondTab.dataSource = self
        tableViewForThirdTab.dataSource = self
        tableViewForFirstTab.registerClass(MyCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableViewForSecondTab.registerClass(MyCell.self, forCellReuseIdentifier: "Cell")
        tableViewForThirdTab.registerClass(MyCell.self, forCellReuseIdentifier: "Cell")
        
        
        self.view.addSubview(tableViewForFirstTab)
        
        menuButton.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        if self.revealViewController() != nil{
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        //rightButton.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.rightRevealToggle(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        firstTab.addTarget(self, action: #selector(ReloadExampleViewController.topNews(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        secondTab.addTarget(self, action: #selector(ReloadExampleViewController.contribution(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        thirdTab.addTarget(self, action: #selector(ReloadExampleViewController.share(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //  obLoaderClass.login_request()
        obLoaderClass.getHeadlines_request()
        
        print("result iss")
        print(detailsArray)
        
        
    }
    
    func topNews(sender: AnyObject) {
        NSLog("selected")
        tab1 = true
        tab2 = false
        tab3 = false
        view.reloadInputViews()
        view.addSubview(tableViewForFirstTab)
        
        setColorForTab(firstTab, sender2: secondTab, sender3: thirdTab)
        
    }
    
    func contribution(sender: AnyObject) {
        tab2 = true
        tab1 = false
        tab3 = false
        
        NSLog("contribution selected")
        
        self.view.addSubview(tableViewForSecondTab)
        topNewsView.hidden = true
        contributionView.hidden = false
        shareView.hidden = true
        
    }
    func share(sender: AnyObject) {
        tab3 = true
        tab2 = false
        tab1 = false
        NSLog("share selected")
        view.addSubview(tableViewForThirdTab)
        shareView.hidden = false
        topNewsView.hidden = true
        contributionView.hidden = true
        
    }
    func setColorForTab(sender: UIButton,sender2: UIButton,sender3 : UIButton) -> Void {
        if tab1 && !tab2 && !tab3{
            shareView.hidden = true
            topNewsView.hidden = false
            contributionView.hidden = true
            
        }
        else if !tab1 && tab2 && !tab3{
            
            shareView.hidden = true
            topNewsView.hidden = true
            contributionView.hidden = false
            
        }
        else if !tab1 && !tab2 && tab3{
            shareView.hidden = false
            topNewsView.hidden = true
            contributionView.hidden = true
            
            
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:MyCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MyCell
        cell.setupCell()
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 1
        
        cell.clipsToBounds = true
        
        if tab2{
            
            cell.headLine?.text = "New Mechanims By which new neurons sharpen memories"
            cell.commentedTime?.text = "22h ago"
            cell.newsImage?.image = UIImage(named: "placeholder")
            cell.exit?.setBackgroundImage(UIImage(named: "ic_exit_to_app"), forState: UIControlState.Normal)
            cell.share?.setBackgroundImage(UIImage(named: "ic_share_footer"), forState: UIControlState.Normal)
            cell.bookmark?.setBackgroundImage(UIImage(named: "ic_bookmark_outline"), forState: UIControlState.Normal)
            
            
        }
        else if tab3{
            cell.headLine?.text = "New Mechanims By which new neurons sharpen memories"
            cell.commentedTime?.text = "22h ago"
            cell.newsImage?.image = UIImage(named: "placeholder")
            cell.exit?.setBackgroundImage(UIImage(named: "ic_exit_to_app"), forState: UIControlState.Normal)
            cell.share?.setBackgroundImage(UIImage(named: "ic_share_footer"), forState: UIControlState.Normal)
            cell.bookmark?.setBackgroundImage(UIImage(named: "ic_bookmark_outline"), forState: UIControlState.Normal)
            
        }else{
            cell.headLine?.text = "New Mechanims By which new neurons sharpen memories"
            cell.commentedTime?.text = "22h ago"
            cell.newsImage?.image = UIImage(named: "placeholder")
            cell.exit?.setBackgroundImage(UIImage(named: "ic_exit_to_app"), forState: UIControlState.Normal)
            cell.share?.setBackgroundImage(UIImage(named: "ic_share_footer"), forState: UIControlState.Normal)
            cell.bookmark?.setBackgroundImage(UIImage(named: "ic_bookmark_outline"), forState: UIControlState.Normal)
            
        }
        
        return cell
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
