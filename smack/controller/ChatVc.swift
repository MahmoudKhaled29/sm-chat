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
            //get message and channels
            onLogInGetMessage()
            //channelNamelbl.text = "chat"
        }else{
            channelNamelbl.text = "Please Log IN"
        }
    }
    
    @objc func channelSelected(_ notif : Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNamelbl.text = "#\(channelName)"
        //get messages which it contained in the selected specific channel
        getMessages()
    }
    
    func onLogInGetMessage(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                //check if there is a channell
                if MessageService.instance.channels.count > 0 {
                    //make the selected channel is the first channel by default
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    //after make the one is dafult updatewith channel we update the view with selected channel
                    self.updateWithChannel()
                }else{
                    self.channelNamelbl.text = "NO Channels yet"
                }
            }
        }
    }
    
   
    
    //function to get messages on specific channel
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?._id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                print("Finally you'r welcom")
            }
        }

    }
    
    
}
