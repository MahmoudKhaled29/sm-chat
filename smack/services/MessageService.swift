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
    var messages = [Message]()
    var selectedChannel : Channel?
    
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
              //  let chanel = Channel(_id: "52", name: "Mahmoud", description: "tmam")
              //  self.channels.append(chanel)
                NotificationCenter.default.post(name: NOTIF_CHANNELES_LOADES, object: nil)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    
    //methhod to get messages
    func findAllMessagesForChannel(channelId : String , completion : @escaping completionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BREAR_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let newMessage = Message(message: messageBody, userId: id, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                            self.messages.append(newMessage)
                        }
                    }
                }catch{
                    print("Message Error while parsin")
                }
                print(self.messages)
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
                
            }
            
        }
        
        
    }
    
    
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannel(){
        channels.removeAll()
    }
    
}
