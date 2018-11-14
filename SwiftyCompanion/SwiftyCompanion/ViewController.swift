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
//var displayName = ""
//var user = ""
//var city = ""
//var email = ""
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
        
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/"+(userName)+"?access_token="+(token))!)
        
        request.httpMethod = "GET"
        
        let dispatch = DispatchGroup()
        print("you there?")
        let newTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
            }
            else
            {
                let httpResponse = response as! HTTPURLResponse
                print (httpResponse.statusCode)
                if (httpResponse.statusCode == 200)
                {
                    if let returnedData = data {
                        jsonData = JSON(returnedData)
                        print (jsonData)
                        //print (jsonData!["displayname"].string)
                    }
                }
                else
                {
                    print("404: user not found")
                    self.showAlert()
                }
            }
            dispatch.leave()
            print("uhuhuh")
        }
        dispatch.enter()
        newTask.resume()
        dispatch.wait()
        print ("HEY")
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            (data, response, error) in
//            print("maybe")
//            //print(response as Any)
//            if error != nil {
//                print(error as Any)
//            }
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 200 {
//                    if let returnedData = data {
//                        jsonData = JSON(returnedData)
                        //jsonData = json
//                        if json["displayname"].string == nil {
//                            userName = ""
//                            print("No user found")
//                        }
//                        else
//                        {
//                            if self.shouldPerformSegue(withIdentifier: "secondView", sender: sender)
//                            {
                                //print(json)
//                                displayName = json["displayname"].string!
//                                user = json["login"].string!
//                                city = json["campus"][0]["city"].string!
//                                email = json["email"].string!
//                                print(displayName + "\n" + user + "\n" + city + "\n" + email)
//                            }
//                        }
//                        print (jsonData!["displayname"].string!)
//                }
//
//            }
//            else {
//                print("404: user not found")
//                }
//            }
//            //dispatch.leave()
//        }
        //dispatch.enter()
        //task.resume()
        //dispatch.wait()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        userName = userField.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if userName != "" {
            getUserInfo(sender: sender)
        }
        else {
            print("Please enter a username")
            self.showAlert()
            
        }
        //print(userName)
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if  {
//            return false
//        }
//        return true
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string :String) -> Bool
//    {
//        let allowedCharacters = CharacterSet.letters
//        let characterSet = CharacterSet(charactersIn: string)
//        return allowedCharacters.isSuperset(of: characterSet)
//    }
}

