//
//  displayViewController.swift
//  SwiftyCompanion
//
//  Created by Yen-Ho CHEN on 2018/10/30.
//  Copyright © 2018 Kyle ROUTLEDGE. All rights reserved.
//

import UIKit

class displayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var projectTableView: UITableView! {
        didSet {
            projectTableView.delegate = self
            projectTableView.dataSource = self
        }
    }
    
//    func setProfilePic() {
//        let imageURL = jsonData!["image_url"].string!
//        if let url = NSURL(sting: imageURL) {
//
//        }
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Projects segment selected")
            return jsonData!["projects_users"].count
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            print("Skills segment selcted")
            return jsonData!["cursus_users"][0]["skills"].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("PROJECTS SEGMENT")
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
            cell?.textLabel?.text = jsonData!["projects_users"][indexPath.row]["project"]["name"].string!
            let mark = "\(String(describing: jsonData!["projects_users"][indexPath.row]["final_mark"]))"
            cell?.detailTextLabel?.text = mark
            print(jsonData!["projects_users"][indexPath.row]["final_mark"])
            return cell!
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            print("SKILLS SEGEMENT")
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
            cell?.textLabel?.text = jsonData!["cursus_users"][0]["skills"][indexPath.row]["name"].string
            let level = "\(String(describing: jsonData!["cursus_users"][0]["skills"][indexPath.row]["level"]))"
            cell?.detailTextLabel?.text = level
            print(jsonData!["cursus_users"][0]["skills"][indexPath.row]["name"])
            return cell!
        }
        
        print ("NOT in if/else statement")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
        cell?.textLabel?.text = jsonData!["projects_users"][indexPath.row]["project"]["name"].string!
        let mark = "\(String(describing: jsonData!["projects_users"][indexPath.row]["final_mark"]))"
        cell?.detailTextLabel?.text = mark
        print(jsonData!["projects_users"][indexPath.row]["final_mark"])
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = displayName
        userNameLabel.text = user
        cityLabel.text = city
        emailLabel.text = email
        let url = URL(string: jsonData!["image_url"].string!)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            profilePic.image = UIImage(data: imageData)
        }
        print(jsonData!["cursus_users"][0]["level"])
        //setProfilePic()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func segmentChangeValue(_ sender: Any) {
            projectTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
