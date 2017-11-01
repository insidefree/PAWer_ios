//
//  ViewController.swift
//  PAWer
//
//  Created by Denis Sorokin on 31/10/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        print("login")
    }
    @IBAction func registerTapped(_ sender: Any) {
        print("register")
    }
}

