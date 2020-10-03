//
//  links.swift
//  St Augustine CHS
//
//  Created by Sam Liu on 2020-06-17.
//  Copyright © 2020 St Augustine CHS. All rights reserved.
//

import UIKit

class links: UIViewController {

    @IBOutlet weak var background1: UILabel!
    @IBOutlet weak var prayerRequestButton: UIButton!
    @IBOutlet weak var background2: UILabel!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var background3: UILabel!
    @IBOutlet weak var titanTimesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.background1.layer.cornerRadius = 20
        self.prayerRequestButton.layer.cornerRadius = 20
        self.background2.layer.cornerRadius = 20
        self.twitterButton.layer.cornerRadius = 20
        self.background3.layer.cornerRadius = 20
        self.titanTimesButton.layer.cornerRadius = 20
        self.titanTimesButton.layer.zPosition = 1
    }
    
    @IBAction func didTapPrayer(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://forms.gle/gVqcL4UPv3uX7hVz6")! as URL)
    }
    
    
    @IBAction func didTapTwitter(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"https://twitter.com/STAUpdates")! as URL)
    }
    
    @IBAction func didTapTitanTimes(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"https://titantimes.live/")! as URL)
    }
    
}


