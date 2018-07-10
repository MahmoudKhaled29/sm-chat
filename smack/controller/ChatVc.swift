//
//  ChatVc.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/13/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChatVc: UIViewController , UITableViewDataSource , UITableViewDelegate{
    //outLet
    @IBOutlet weak var menubtn: UIButton!
    @IBOutlet weak var channelNamelbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    //variables
    var isTyping = false
    //undo segue
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue){}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to make view go up when type a message
        view.bindToKeyboard()
        //when touch view the editing is dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVc.touchView))
        view.addGestureRecognizer(tap)
        
        //tabel view
        tabelview.dataSource = self
        tabelview.delegate = self
        tabelview.estimatedRowHeight = 80
        //make the row is dynamic with constraits
        tabelview.rowHeight = UITableViewAutomaticDimension
        
        sendBtn.isHidden = true
        
        // to open slide side menu  //for slide menue
        menubtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //for slide and open it up
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //for slide to cancel the rear view
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //to load channel if user is login
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.userDataDidChange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        
        //to change then name of channel on bar
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        //listen to new message (real time appear message)
        SocketService.instance.getChatMessage { (success) in
            if success{
                self.tabelview.reloadData()
                //when message send the tabel view scrollDown
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
                    self.tabelview.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        //to get information about the user name which is stored in userDefaults
        //then blasting out that so the information can be set to channelVc
        //you must call it in viewDidApear of channel Vc
        
        if AuthService.instance.isLoggin{
            AuthService.instance.userByEmail { (success) in
                // post and blasting that the data is changed when open app after closed it
                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
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
            tabelview.reloadData()
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
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                print("Finally you'r welcom")
                self.tabelview.reloadData()
            }
        }
        
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTxt.text == ""{
            isTyping = false
            sendBtn.isHidden = true
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
                }
            isTyping = true
        }
    }
    
    
    @IBAction func sedMessagePresses(_ sender: Any) {
        if AuthService.instance.isLoggin {
            guard let selectedChannelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxt.text , messageTxt.text != "" else {return}
            
            //send message to store it in bataBase and emit it again
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: selectedChannelId) { (success) in
                if success{
                    // get back the first design 
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                }
            }
        }
    }
    
    @objc func touchView(){
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)  as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configurationCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
        
    }

}
