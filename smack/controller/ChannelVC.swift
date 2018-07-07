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
        // the size of rear view screen 
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        // when the notification center is done
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidchange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        //set Table view
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    //to reload user information
   override func viewDidAppear(_ animated: Bool) {
        print("didApear")
        setUPUserInfo()
    }

    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
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
    
}
