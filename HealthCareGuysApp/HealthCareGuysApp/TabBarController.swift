//
//  TabBarController.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 16/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var obLoaderClass = LoaderClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.tintColor = UIColor().HexToColor("#00D7D7", alpha: 1.0)
      
    }

}
