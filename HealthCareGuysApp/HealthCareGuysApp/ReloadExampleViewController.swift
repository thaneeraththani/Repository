//  ReloadExampleViewController.swift


import UIKit


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
    
    var tab1: Bool = true
    var tab2:Bool = false
    var tab3:Bool  = false
    var items :[String] = ["head Line 1","Head line 2","Head Line 3"]
    var contItems:[String] = ["contribution 1","Contribution 2","Contribution 3"]
    var shareItems:[String] = ["Share 1","Share 2","Share 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
       

        topNewsView.hidden = false
        contributionView.hidden = true
        shareView.hidden = true
       tableViewForFirstTab.frame =   CGRectMake(0, 105, view.frame.height, view.frame.width);
        tableViewForSecondTab.frame =  CGRectMake(0, 105, view.frame.height, view.frame.width);
        tableViewForThirdTab.frame =  CGRectMake(0, 105, view.frame.height, view.frame.width);
        tableViewForFirstTab.delegate = self
        tableViewForSecondTab.delegate = self
        tableViewForThirdTab.delegate = self
        tableViewForFirstTab.dataSource = self
        tableViewForSecondTab.dataSource = self
        tableViewForThirdTab.dataSource = self
        tableViewForFirstTab.registerClass(MainCellItems.self, forCellReuseIdentifier: "Cell")
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
       
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! MainCellItems
        if tab2{
                }
        else if tab3{
                  }else{
                   }
      
         return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }
