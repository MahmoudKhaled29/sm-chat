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


//segues
let to_Login = "toLogin"
let to_creat_acount = "toCreatAcount"
let UNWIND = "unwindToChannel"

//user Defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"]
