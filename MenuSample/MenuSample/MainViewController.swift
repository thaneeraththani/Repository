//
//  MainViewController.swift
//  MenuSample
//
//  Created by Thaneerath on 30/08/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
  
  
     override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(),  action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        
        }
    

}
