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
    @IBOutlet weak var channelNamelbl: UILabel!
    
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
        
        //to load channel if user is login
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.userDataDidChange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        
        //to change then name of channel on bar
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
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
      /*  MessageService.instance.findAllChannels { (success) in
            if success{
                print("Welcom chanels")
            }
        } */
    }
    @objc func userDataDidChange(_ notifi: Notification){
        if AuthService.instance.isLoggin {
            //get message
            
            onLogInGetMessage()
            channelNamelbl.text = "chat"
        }else{
            channelNamelbl.text = "Please Log IN"
        }
    }
    
    @objc func channelSelected(_ notif : Notification){
        updateWithChannel()
    }
    
    
    func onLogInGetMessage(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                //do stuff with channel
            }
        }
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNamelbl.text = "#\(channelName)"
    }
    
    
    
    
}
