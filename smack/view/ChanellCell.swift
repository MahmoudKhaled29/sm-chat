//
//  ChanellCell.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/5/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChanellCell: UITableViewCell {

    //outlets
    @IBOutlet weak var channelNamelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configurationCell(channel : Channel)  {
        let title = channel.name ?? ""
        channelNamelbl.text = "#\(title)"
    }

}
