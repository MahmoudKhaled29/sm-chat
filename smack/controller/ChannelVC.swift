//
//  ChannelVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/13/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //outlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // the size of rear view screen 
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        // when the notification center is done
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidchange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        
    }

  
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: to_Login, sender: nil)
    }
    
    @objc func userDataDidchange(_ : Notification){
        if AuthService.instance.isLoggin{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(compnentS: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "profileDefault")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
}
