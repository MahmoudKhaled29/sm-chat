//
//  ProfileVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/4/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //outlets
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    @IBAction func closedPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.loggedOut()
        NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    

    func setUpView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(compnentS: UserDataService.instance.avatarColor)
        
        let touchColose = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeProfile(_:)))
        bgView.addGestureRecognizer(touchColose)
        
        
    }
  
    @objc func closeProfile(_ : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
