//
//  CreatAcountVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/22/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class CreatAcountVC: UIViewController {

    //outlet
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    @IBAction func closedbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func creatAccPressed(_ sender: Any) {
        guard let name = usernameTxt.text , usernameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        AuthService.instance.registrationUsers(email: email, password: pass) { (success) in
            if success {
                print("Reister seccessed!")
                AuthService.instance.loginUsed(email: email, password: pass, completion: { (success) in
                    if success{
                        print("logged in user!")
                        AuthService.instance.creatUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                print("User has been created!")
                                print(UserDataService.instance.name , UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
                
            }
        }
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    
    @IBAction func pickerBGColorPressed(_ sender: Any) {
    }
    
}
