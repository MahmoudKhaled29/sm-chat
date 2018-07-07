//
//  loginVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 6/20/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var userEmail: TextFiledView!
    @IBOutlet weak var passTxt: TextFiledView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spiner.isHidden = true
        setUpView()
        // Do any additional setup after loading the view.
    }

    @IBAction func closedbtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func creatAcountbtnPressed(_ sender: Any) {
       performSegue(withIdentifier: to_creat_acount, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spiner.isHidden = false
        spiner.startAnimating()
        
        guard let email = userEmail.text , userEmail.text != "" else{return}
        guard let password = passTxt.text , passTxt.text != "" else{return}
        
        AuthService.instance.loginUsed(email: email, password: password) { (success) in
            if success {
                print("login Succes")
                AuthService.instance.userByEmail(completion: { (success) in
                    if success{
                        print("USer data is backed")
                        NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
                        self.spiner.isHidden = true
                        self.spiner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    func setUpView(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginVC.touchView))
        view.addGestureRecognizer(tap)
    }
    @objc func touchView(){
        view.endEditing(true)
    }

}
