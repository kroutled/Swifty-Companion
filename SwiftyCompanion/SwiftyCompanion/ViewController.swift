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
let api = ApiController()
var jsonData: JSON?

class ViewController: UIViewController /*UITextFieldDelegate*/ {
    @IBOutlet weak var userField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getToken()
        //self.userField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "No Username enetered", message: "Please enter valid username", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getUserInfo(sender: Any?) {
        jsonData = nil
        
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/"+(userName)+"?access_token="+(token))!)
        
        request.httpMethod = "GET"
        
        let dispatch = DispatchGroup()

        let newTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
            }
            else
            {
                let httpResponse = response as! HTTPURLResponse
                print (httpResponse.statusCode)
                if (httpResponse.statusCode != 200) {
                    //self.showAlert()
                    print(httpResponse.statusCode, " :ERROR!")
                }
                else if (httpResponse.statusCode == 200)
                {
                    if let returnedData = data {
                        jsonData = JSON(returnedData)
                        //print (jsonData)
                        //print (jsonData!["displayname"].string)
                    }
                }
            }
            dispatch.leave()
        }
        dispatch.enter()
        newTask.resume()
        dispatch.wait()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        userName = userField.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if userName != "" {
            getUserInfo(sender: sender)
            if jsonData != nil {
                self.performSegue(withIdentifier: "firstToSecond", sender: sender)
            }
        }
        else {
            print("Please enter a username")
            self.showAlert()
        }
    }
    
}
