//
//  ChannelVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/13/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    //outlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // the size of rear view screen
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
       
        // when the notification center is done
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidchange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELES_LOADES, object: nil)
        
        
        //get new channels which it created by user
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        
    }
    //to reload user information
   override func viewDidAppear(_ animated: Bool) {
        print("didApear")
        setUPUserInfo()
    }

    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggin {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Oops", message: "You must be login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggin{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: to_Login, sender: nil)
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChanellCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configurationCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = selectedChannel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        //dismiss reavealView
        self.revealViewController().revealToggle(animated: true)
    }
    
    @objc func channelsLoaded(_ notif : Notification){
        tableView.reloadData()
    }
    
    @objc func userDataDidchange(_ : Notification){
        setUPUserInfo()
    }
    
    func setUPUserInfo(){
        if AuthService.instance.isLoggin{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(compnentS: UserDataService.instance.avatarColor)
            
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "profileDefault")
            userImg.backgroundColor = UIColor.clear
            //to clear channels we use tabel view reload data cause array was empty at this second
            self.tableView.reloadData()
        }
    }
    
}
