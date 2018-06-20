//
//  GradientView.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/20/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor:UIColor = #colorLiteral(red: 0.3118079305, green: 0.3459454775, blue: 0.8450406194, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
   
    @IBInspectable var botomColor:UIColor = #colorLiteral(red: 0.3607843137, green: 0.7725490196, blue: 0.8078431373, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
       let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor , botomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
      self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
