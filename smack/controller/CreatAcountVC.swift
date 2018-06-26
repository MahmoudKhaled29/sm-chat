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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closedbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func creatAccPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        AuthService.instance.registrationUsers(email: email, password: pass) { (success) in
            if success {
                print("Reister seccessed!")
                AuthService.instance.loginUsed(email: email, password: pass, completion: { (success) in
                    if success{
                        print("logged in user!", AuthService.instance.authToken)
                    }
                })
                
            }
        }
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    
    @IBAction func pickerBGColorPressed(_ sender: Any) {
    }
    
}
