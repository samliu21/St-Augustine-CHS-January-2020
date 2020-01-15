//
//  spiritMeterController.swift
//  St Augustine CHS
//
//  Created by Kenny Miu on 2018-12-05.
//  Copyright © 2018 St Augustine CHS. All rights reserved.
//

import UIKit
import Firebase

class spiritMeterController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var nineLabel: UILabel!
    @IBOutlet weak var tenLabel: UILabel!
    @IBOutlet weak var elevenLabel: UILabel!
    @IBOutlet weak var twelveLabel: UILabel!
    
    @IBOutlet weak var nineBar: UIProgressView!
    @IBOutlet weak var tenBar: UIProgressView!
    @IBOutlet weak var elevenBar: UIProgressView!
    @IBOutlet weak var twelveBar: UIProgressView!
    @IBOutlet weak var spiritRules: UITableView!

    var tableViewData = [cellData]()
    let cellSpacingHeight: CGFloat = 2.5
    
    //The Database
    var db: Firestore!
    var docRef: DocumentReference!
    
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
● Active participant in any Titans event i.e. performing in coffeehouse,participating in a buy-out, Titan Tuesday competition, costume contest, winning a kahoot, etc. (excluding sports teams, art, drama)
*on top of the 80 points given for attending the Titans event* → 80
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: "Level 1 (0-25) The student demonstrates an interest in school spirit.", sectionData: [sectionData1]),
                                cellData(opened: false, title: "Level 2 (26-50) The student demonstrates a considerable amount of school spirit.", sectionData: [sectionData2]),
                                cellData(opened: false, title: "Level 3 (51-75) The student demonstrates great school spirit", sectionData: [sectionData3]),
                                cellData(opened: false, title: "Level 4 (76-100) The student demonstrates a remarkable and outstanding display of school spirit", sectionData: [sectionData4]),
                                ]
               spiritRules.rowHeight = UITableView.automaticDimension
               spiritRules.estimatedRowHeight = 50
        
        //***************INTERNET CONNECTION**************
        var iAmConneted = false
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                print("Connected")
                iAmConneted = true
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    print(iAmConneted)
                    if !iAmConneted{
                        print("Not connected")
                        let alert = UIAlertController(title: "Error", message: "You are not connected to the internet", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        })
        
        //Set Up
        // [START setup]
        let settings = FirestoreSettings()
        //settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        nineBar.tintColor = Defaults.accentColor
        tenBar.tintColor = Defaults.accentColor
        elevenBar.tintColor = Defaults.accentColor
        twelveBar.tintColor = Defaults.accentColor
        
        //Format the progress bars
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        
        self.nineBar.transform = transform
        self.tenBar.transform = transform
        self.elevenBar.transform = transform
        self.twelveBar.transform = transform
        
        //Get the points
        getSpiritPoints()
    }
    
    func getSpiritPoints() {
        db.collection("info").document("spiritPoints").getDocument { (snapshot, err) in
            if let err = err {
                let alert = UIAlertController(title: "Unable to get spirit data", message: "Error: \(err.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            if let snapshot = snapshot {
                let data = snapshot.data() ?? ["years":["1","2","3","4"], "1": 100, "2": 100, "3": 100, "4": 100]
                
                //Set the values
                let years = data["years"] as? [String] ?? ["1","2","3","4"]
                
                let nine = data[years[3]] as? Double ?? 100
                let ten = data[years[2]] as? Double ?? 100
                let eleven = data[years[1]] as? Double ?? 100
                let twelve = data[years[0]] as? Double ?? 100
                
                let points = [nine,ten,eleven,twelve]
                
                //Set the max to the leading grade
                let max:Double = Double(points.max() ?? 1)
                
                //Set the progress bars
                self.nineBar.progress = Float(nine/max)
                self.tenBar.progress = Float(ten/max)
                self.elevenBar.progress = Float(eleven/max)
                self.twelveBar.progress = Float(twelve/max)
                
                //Update the labels
                self.nineLabel.text = "Grade 9 - \(Int(nine)) Points"
                self.tenLabel.text = "Grade 10 - \(Int(ten)) Points"
                self.elevenLabel.text = "Grade 11 - \(Int(eleven)) Points"
                self.twelveLabel.text = "Grade 12 - \(Int(twelve)) Points"
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpiritPointsRules") else {return UITableViewCell()}
                   cell.textLabel?.text = tableViewData[indexPath.section].title
                   return cell
               }else{
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpiritPointsRules") else {return UITableViewCell()}
                   cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                   return cell
               }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

}
