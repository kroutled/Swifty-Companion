//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Kyle ROUTLEDGE on 2018/10/26.
//  Copyright © 2018 Kyle ROUTLEDGE. All rights reserved.
//

import UIKit

var userName: String = ""
var token = ""

class ViewController: UIViewController {
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
                json1 = JSON(d)
            }
            dispatch.leave()
        }
        dispatch.enter()
        task.resume()
        dispatch.wait()
    }
}

