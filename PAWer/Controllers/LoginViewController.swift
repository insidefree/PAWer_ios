//
//  ViewController.swift
//  PAWer
//
//  Created by Denis Sorokin on 31/10/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    @objc func kbDidShow(notification: Notification){
        guard let userInfo = notification.userInfo else {return}
        print("userInfo: \(userInfo)")
        let kbFrameSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print("frameSize \(kbFrameSize)")
        print(self.view.bounds.size)
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        print(self.view)
//        self.view.bounds.size = CGSize(width: self.view.bounds.size.width, height: 1000)
        print(self.view.bounds.size)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide(){
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
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

