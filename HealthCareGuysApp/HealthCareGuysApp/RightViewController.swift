//
//  RightViewController.swift
//  MenuSample
//
//  Created by Thaneerath on 31/08/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.target = self.revealViewController()
        menuButton.action = "revealToggle:"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        rightButton.target = self.revealViewController()
        rightButton.action =  "rightRevealToggle:"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
