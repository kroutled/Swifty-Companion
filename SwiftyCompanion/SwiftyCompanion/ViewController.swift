//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Kyle ROUTLEDGE on 2018/10/26.
//  Copyright © 2018 Kyle ROUTLEDGE. All rights reserved.
//

import UIKit
import SwiftyJSON

var userName: String = ""
var token = ""

class ViewController: UIViewController {
    @IBOutlet weak var userField: UITextField!
    @IBAction func searchButton(_ sender: Any) {
        if userField.text != "" {
            userName = userField.text!
            let api = ApiController()
            api.getToken()
            getUserInfo()
        }
        else {
            print("Please enter a username")
        }
        print(userName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserInfo() {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/"+(userName)+"?access_token="+(token))!)
        request.httpMethod = "GET"
        let dispatch = DispatchGroup()
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            //print(response as Any)
            if error != nil {
                print(error as Any)
            }
            else if let d = data {
                let json1 = JSON(d)
                print(json1)
            }
            dispatch.leave()
        }
        dispatch.enter()
        task.resume()
        dispatch.wait()
    }
}

