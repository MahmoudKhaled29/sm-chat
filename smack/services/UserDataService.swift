//
//  UserDataService.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/27/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id : String , color : String , avatarName: String, email: String , name: String){
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    // to return the background of image
    func returnUIColor(compnentS : String) -> UIColor{
        
        // "[0.5, 0.5, 0.5, 1]" Example of string which hase been catched with the api
        let scanner = Scanner(string: compnentS)
        let skiped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skiped
        
        
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else{return defaultColor}
        guard let gUnwrapped = g else{return defaultColor}
        guard let bUnwrapped = b else{return defaultColor}
        guard let aUnwrapped = a else{return defaultColor}
        // there is not direct way to convert the string value to cgfloat so weconvert it to doublevalue the to cgFolat
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        
        let color = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)

        return color
    }
    
    
    
    
    
    
}
