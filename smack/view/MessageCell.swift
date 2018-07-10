//
//  MessageCell.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/8/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var messagelbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configurationCell(message : Message){
        self.userImg.image = UIImage(named: message.userAvatar)
        self.userImg.backgroundColor = UserDataService.instance.returnUIColor(compnentS: message.userAvatarColor)
        self.userNamelbl.text = message.userName
        self.messagelbl.text = message.message
        
    }
    

}
