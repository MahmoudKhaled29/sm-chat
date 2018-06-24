//
//  loginVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/20/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closedbtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func creatAcountbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: to_creat_acount, sender: nil)
    }
    
   

}
