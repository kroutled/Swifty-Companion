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
    
    @IBOutlet weak var projectTableView: UITableView! {
        didSet {
            projectTableView.delegate = self
            projectTableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData!["projects_users"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
        cell?.textLabel?.text = jsonData!["projects_users"][indexPath.row]["project"]["name"].string!
        cell?.detailTextLabel?.text = jsonData!["projects_users"][indexPath.row]["final_mark"].string
        print(jsonData!["projects_users"][indexPath.row]["final_mark"])
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = displayName
        userNameLabel.text = user
        cityLabel.text = city
        emailLabel.text = email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
