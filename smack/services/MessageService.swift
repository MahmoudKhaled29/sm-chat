//
//  MessageService.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/5/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    var channels = [Channel]()
    
    func findAllChannels(completion : @escaping completionHandler){
        
        Alamofire.request(URL_GET_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BREAR_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                //parse json with codable
               /* do{
                    //let decoder = JSONDecoder()
                   // let json = try decoder.decode([Channel].self, from: data)
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                }catch let error{
                    debugPrint("JsonError",error as Any)
                } */
                
                 //with swiftyJSON
                do{
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(_id: id, name: name, description: channelDescription)
                            self.channels.append(channel)
                        }
                    }
                    
                }catch{
                    print("Error with parsing")
                }
                let chanel = Channel(_id: "52", name: "Mahmoud", description: "tmam")
                self.channels.append(chanel)
                print(self.channels)
                
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
}
