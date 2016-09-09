//
//  DetailViewController.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 09/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UINavigationControllerDelegate {
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var offlineReadButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.layer.cornerRadius = self.shareButton.frame.size.width / 4
        shareButton.clipsToBounds = true

        offlineReadButton.layer.cornerRadius = self.offlineReadButton.frame.size.width / 4
        offlineReadButton.clipsToBounds = true

        starButton.layer.cornerRadius = self.starButton.frame.size.width / 4
        starButton.clipsToBounds = true

       favouriteButton.layer.cornerRadius = self.favouriteButton.frame.size.width / 4
        favouriteButton.clipsToBounds = true

    }

}
