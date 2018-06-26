//
//  RoundedButton.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/26/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 3.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView()  {
        self.layer.cornerRadius = cornerRadius
    }

}
