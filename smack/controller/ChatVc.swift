//
//  ChatVc.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/13/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class ChatVc: UIViewController {
    //outLet
    @IBOutlet weak var menubtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for slide menue
        menubtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //for slide and open it up
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //for slide to cancel the rear view
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
      
        
    }
   
    }
