//
//  TextFiledView.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/4/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

@IBDesignable
class TextFiledView: UITextField {

    override func awakeFromNib() {
        customeView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customeView()
    }

    func customeView()  {
       
        //check if there is a placeholder or not
        if let placehodlerTxt = placeholder{
            //custome coler of font
            let cplacehlder = NSAttributedString(string: placehodlerTxt, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.5)])
            attributedPlaceholder = cplacehlder
        }
    }
}
