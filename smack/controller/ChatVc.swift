//
//  ChatVc.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/13/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChatVc: UIViewController {
    //outLet
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var menubtn: UIButton!
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue){}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        //for slide menue
        menubtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //for slide and open it up
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //for slide to cancel the rear view
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        
        //to get information about the user name which is stored in userDefaults
        //then blasting out that so the information can be set to channelVc
        //you must call it in viewDidApear of channel Vc
        if AuthService.instance.isLoggin{
            spinner.isHidden = false
            spinner.startAnimating()
            
            AuthService.instance.userByEmail { (success) in
                
                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
                
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
            }
        }
        MessageService.instance.findAllChannels { (success) in
            if success{
                print("Welcom chanels")
            }
        }
    }
   
    }
