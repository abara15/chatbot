//
//  ContactsVC.swift
//  chatBot
//
//  Created by Anthony Barakat on 6/27/18.
//  Copyright © 2018 Anthony Barakat. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    

} //class
