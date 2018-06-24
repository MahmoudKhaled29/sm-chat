//
//  AuthService.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/24/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
     static let instance = AuthService()
    
    let defaults = UserDefaults()
    
    var isLoggin :Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }

    func registrationUsers(email : String , password : String ,  completion : @escaping completionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let header = [ "Content-Type":"application/json; charset=utf8" ]
        let body = ["email":lowerCaseEmail ,
                    "password":password ]
        
        Alamofire.request(urlRegistration, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
  
    
    
    
    
    
    
    
    
    
}
