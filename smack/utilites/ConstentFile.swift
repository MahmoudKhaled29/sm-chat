//
//  ConstentFile.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/20/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import Foundation

//clousers.
typealias completionHandler = (_ Success : Bool) -> ()

//URLs
let baseURL = "https://chattychatchat29.herokuapp.com/v1/"
let urlRegistration = "\(baseURL)account/register"
let URL_LOGIN = "\(baseURL)account/login"
let URL_USER_ADD = "\(baseURL)user/add"
let URL_FIND_BY_EMAIL = "\(baseURL)/user/byEmail/"
let URL_GET_CHANNEL = "\(baseURL)channel/"
let URL_GET_MESSAGES = "\(baseURL)message/byChannel/"

//segues
let to_Login = "toLogin"
let to_creat_acount = "toCreatAcount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user Defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"]

let BREAR_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

//notifications Name
let NOTIF_USER_DID_CHANGE = Notification.Name("notificationUserDataChange")
let NOTIF_CHANNELES_LOADES = Notification.Name("ChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")



