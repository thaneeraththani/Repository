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
       // obLoaderClass.login_request()
      //  obLoaderClass.getHeadlines_request()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = UIColor.blackColor()
        self.tabBar.tintColor = UIColor.whiteColor()
    }

}
