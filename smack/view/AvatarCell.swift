//
//  AvatarCell.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/2/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    func configCell(type: AvatarType , index : Int)  {
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            avatarImg.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func updateView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
