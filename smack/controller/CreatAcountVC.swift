//
//  CreatAcountVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/22/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class CreatAcountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closedbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
