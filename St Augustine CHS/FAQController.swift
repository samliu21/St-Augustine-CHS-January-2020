//
//  FAQController.swift
//  St Augustine CHS
//
//  Created by Jonathan Woo on 2019-10-23.
//  Copyright © 2019 St Augustine CHS. All rights reserved.
//

import UIKit

struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FAQController: UITableViewController{
    
    var tableViewData = [cellData]()
    let cellSpacingHeight: CGFloat = 2.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [cellData(opened: false, title: "If I spend my spirit points, does it take away from the spirit points of my grade?", sectionData: ["No. Although the spirit points you gain individually are added to your grades overall spirit meter, these points will not be taken away once you decide to spend them."]),
                         cellData(opened: false, title: "How do I keep my school information private?", sectionData: ["To ensure other students cannot see your courses or clubs, go to the home screen and click the three dots on the top left corner, and then go into settings. From there, turn on the toggle switch to keep classes and clubs private."]),
                         cellData(opened: false, title: "How do you get more badges? Will each club have one?", sectionData: ["You can get more badges by joining different clubs, however, badges can only be earned once you have been accepted into the club by your club administrator. No, not all clubs have badges. It is up to the club administrator if they wish to add them."]),
                         cellData(opened: false, title: "What does “Clear Cache” do?", sectionData: ["We store images on the app so that it runs smooth. By clearing cache, you will save storage on your device. The app will still be able to run, however, loading time may take a bit longer."]),
                         cellData(opened: false, title: "Does the app update for snow days on the home page?", sectionData: ["Yes. The app gets its information directly from School Bus City, therefore once updates have been posted on the website, the app will update as well by posting it on the home page as well as sending out a notification (if notifications are on)."]),
                         cellData(opened: false, title: "How do you earn points to spend on profile pics?", sectionData: ["You can earn points by joining clubs which require approval from the administrator. From there you are free to use your points on whatever you wish (ie. song requests, new profile pictures, etc.)"]),
                         cellData(opened: false, title: "Will the caf menu be updated the night before or the morning of?", sectionData: ["The cafeteria menu will be updated on the app the morning of, as this is when the cafeteria posts that day’s menu"]),
                         cellData(opened: false, title: "Is there a place in the app or somewhere we can put suggestions and report bugs?", sectionData: ["Yes!"]),
                         cellData(opened: false, title: "What is the difference between club announcements and school wide announcements?", sectionData: ["Club announcements"]),
                         cellData(opened: false, title: "Can I log into my account on multiple devices?", sectionData: ["Yes, however, the notifications will only appear on the last signed in device."])]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections (in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}
