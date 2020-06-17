//
//  links.swift
//  St Augustine CHS
//
//  Created by Sam Liu on 2020-06-17.
//  Copyright © 2020 St Augustine CHS. All rights reserved.
//

import UIKit

class links: UIViewController {

    @IBAction func didTapPrayer(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://forms.gle/gVqcL4UPv3uX7hVz6")! as URL)
    }

    @IBAction func didTapTwitter(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"https://twitter.com/STAUpdates")! as URL)
    }
    
}
