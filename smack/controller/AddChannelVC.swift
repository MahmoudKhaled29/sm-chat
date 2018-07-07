//
//  AddChannelVC.swift
//  smack
//
//  Created by Mahmoud Khaled on 7/6/18.
//  Copyright © 2018 Mahmoud Khaled. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    @IBOutlet weak var usernameTxt: TextFiledView!
    @IBOutlet weak var channelDescTex: TextFiledView!
    
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true , completion: nil)
    }
    
    @IBAction func creatChannelPressed(_ sender: Any) {
    }
    
    
    func setupView(){
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(AddChannelVC.touchView(_:)))
        view.addGestureRecognizer(tap)
    }
    @objc func touchView(_ recognizer : UITapGestureRecognizer){
    dismiss(animated: true, completion: nil)
    }
    

}
