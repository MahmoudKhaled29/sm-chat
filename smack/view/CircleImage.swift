//
//  CircleImage.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/3/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        updateView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    
    func updateView()  {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
