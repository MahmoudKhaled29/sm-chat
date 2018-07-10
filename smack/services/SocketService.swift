//
//  SocketService.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/7/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    //singletone pattern
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    //variable of socket
    
     let manager = SocketManager(socketURL: URL(string: baseURL)!,config: [.log(true), .compress])
    // let socket : SocketIOClient = SocketIOClient(socketURL : URL(string : baseURL)!)
    //let manager = SocketManager(socketURL: URL(string: "\(baseURL)")!)
    lazy var socket: SocketIOClient = manager.defaultSocket
   
    
    //two funcs used in app delegate
    func establishConnection (){
        socket.connect()
    }
    
    func dissConnection(){
        socket.disconnect()
    }
    
    
    func addChannel(channelName : String , ChannelDescription: String , completion : @escaping completionHandler){
        //emit when the socket is open in server or to say info for socket
        socket.emit("newChannel", channelName, ChannelDescription)
        completion(true)
    }

    
    //this func make a change so we used it in channelVC which that the place would be changed after channel is created
    //which the channelVC contain the tabel view which is would be reload data
    
    func getChannel(completion: @escaping completionHandler){
        
        //when the socket on api emit for client after create channel , api emit for me data so we receive it as socket om
       
        socket.on("channelCreated") { (dataArray, ack) in
            
            //get data as array of any typr
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            //create new channel model
            let newChannel = Channel(id: channelId, name: channelName, description: channelDesc)
            
            //add chanel to array of channel
            MessageService.instance.channels.append(newChannel)
            completion(true)
            
        }
        
    }
    
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion:@escaping completionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody , userId , channelId , user.name , user.avatarName , user.avatarColor)
        completion(true)
        
    }
    
    func getChatMessage(completion: @escaping completionHandler){
        socket.on("messageCreated") { (dataArray, ack ) in
            guard let messageBody = dataArray[0] as? String else {return}
            // guard let userID = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggin{
                let newMessage = Message(message: messageBody, id: id, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else{
                completion(false)
            }
            
            
        }
    }
    
    
}
