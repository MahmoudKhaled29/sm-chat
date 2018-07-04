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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        // if i use custem view of text
        setUpView()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if bgColor == nil && avatarName.contains("light"){
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func closedbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func creatAccPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
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
                                self.spinner.isHidden = true
                                self.spinner.startAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
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
       let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        //set coloer
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        //change the aVatar color value
        avatarColor = "[\(r) , \(g) , \(b) , 1]"
        //make animation of color changed
        UIView.animate(withDuration: 0.5){
            self.userImg.backgroundColor = self.bgColor
        }
        
        
    }
    
    
     
    func setUpView()  {
     /*
     //##to make textfield with specific placeholder
     //## i put it in custem view file to make every text implement it
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.5)]) */
        // make this to when i toouch the screen when end put the user name or paas or to make keybord hiden
        let tab = UITapGestureRecognizer(target: self, action: #selector(CreatAcountVC.handelTap))
        view.addGestureRecognizer(tab)
        
       
    }
    @objc func handelTap(){
        view.endEditing(true)
    }
}
