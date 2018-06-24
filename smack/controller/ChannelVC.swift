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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // the size of rear view screen 
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

  
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: to_Login, sender: nil)
    }
    
}
