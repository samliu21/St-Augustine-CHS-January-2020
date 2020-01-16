//
//  spiritPointsSystemController.swift
//  St Augustine CHS
//
//  Created by Susan Chen on -01-152020.
//  Copyright © 2020 St Augustine CHS. All rights reserved.
//

import UIKit

struct spiritCellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class spiritPointsSystemController: UITableViewController {
    var tableViewData = [spiritCellData]()
    let cellSpacingHeight: CGFloat = 2.5

    let sectionData1 = """
● Joining the app → 10
● Interacting with Student Council social media platforms i.e. participating in a digital poll. → 10
● Taking a picture with Santa → 20
● Mass involvement (passage reader, altar servers, choir/band member) → 25
"""
    let sectionData2 = """
● Participating in candy gram → 30
● Coming to school dressed in a costume. → 30
● Class donation - top 3 classes with most food
1st → 50
2nd → 40
3rd → 30
● Terry Fox - top 3 individual donations
(On top of the 10 points for the
minimum donation and walk)
1st → 50
2nd → 40
3rd → 30
The minimum donation (i.e.$10) and walk → 10
● Holding an executive position on a committee/council or being captain of a team, or leader of a club, managing a team (on top of the points already given for being a part of a school initiative). → 50
"""
    let sectionData3 = """
● Joining club → 55
● Joining team → 55
● Following our Snapchat and/or Instagram page. → 55
● Wear Titan gear on Titan Tuesdays → 60
● Joining committee → 65
● Joining council → 75
● School spirit homeroom participating (i.e. buyout, door decorating, pumpkin decorating) → 75
● Homeroom competition winners. (Additional points on top of involvement)
1st→ 75
2nd→ 65
3rd→ 55
"""
    let sectionData4 = """
● Nominated by teacher/coach for outstanding display of school spirit or random act of kindness→ 100
*requires personal, written explanation*
● Titan of the month award → 100
● Attending any Titans event as an individual not with your homeroom (sports, art, drama, semi, carnival, escape room, coffee house, banquets, movie night etc.) *excludes kahoots → 80
● Active participant in any Titans event i.e. performing in coffeehouse, participating in a buy-out, Titan Tuesday competition, costume contest, winning a Kahoot, etc. (excluding sports teams, art, drama)
*on top of the 80 points given for attending the Titans event* → 80
"""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [spiritCellData(opened: false, title: "Level 1 (0-25) The student demonstrates an interest in school spirit.", sectionData: [sectionData1]),
                        spiritCellData(opened: false, title: "Level 2 (26-50) The student demonstrates a considerable amount of school spirit.", sectionData: [sectionData2]),
                        spiritCellData(opened: false, title: "Level 3 (51-75) The student demonstrates great school spirit", sectionData: [sectionData3]),
                        spiritCellData(opened: false, title: "Level 4 (76-100) The student demonstrates a remarkable and outstanding display of school spirit", sectionData: [sectionData4]),
                                ]
               tableView.rowHeight = UITableView.automaticDimension
               tableView.estimatedRowHeight = 100
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
            cell.textLabel?.numberOfLines = 0
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.textLabel?.numberOfLines = 0
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
