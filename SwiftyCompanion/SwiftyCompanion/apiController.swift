//
//  apiController.swift
//  SwiftyCompanion
//
//  Created by Kyle ROUTLEDGE on 2018/10/29.
//  Copyright © 2018 Kyle ROUTLEDGE. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApiController: NSObject {
    
    let uid: String = "3ce0cfba203335e5cf164cd0c737016e8bf4cd497c2472c05aadb826544b7f6c"
    let secret: String = "23ce1a561ff582fe7686eaedaf51b1ff92ed0423d3923bc7cbe4be33fdae527d"
    
    func getToken() {
        let url = URL(string: "https://api.intra.42.fr/v2/oauth/token")
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)".data(using: String.Encoding.utf8)
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            //print(response as Any)
            if let err = error{
                print(err)
            }
            else if let d = data{
                do{
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        if let temp = dic["access_token"]
                        {
                            token = temp as! String
                            print("get token", token)
                        }
                    }
                }
                catch(let err){
                    print(err)
                }
            }
            group.leave()
        }
        group.enter()
        task.resume()
        group.wait()
    }
}
