//
//  ViewController.swift
//  PAWer
//
//  Created by Denis Sorokin on 31/10/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    let segueIdentifire = "animalsSegue"
    var ref: DatabaseReference!
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        warnLabel.alpha = 0
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil{
                self?.performSegue(withIdentifier: (self?.segueIdentifire)!, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        pswdTextField.text = "" 
    }
    
    @objc func kbDidShow(notification: Notification){
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide(){
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    func displayWarningLabel(withText text: String){
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut],
                    animations: { [weak self] in
            self?.warnLabel.alpha = 1
            
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let pswd = pswdTextField.text, email != "", pswd != ""  else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: pswd) { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occurred")
                return
            }
            
            if user != nil{
                self?.performSegue(withIdentifier: "animalsSegue", sender: nil)
                return
            }
            
            self?.displayWarningLabel(withText: "No such user")
        }
    }
    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTextField.text, let pswd = pswdTextField.text, email != "", pswd != ""  else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: pswd) {[weak self] (user, error) in
          
            guard error == nil, user != nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            let userRef = self?.ref.child((user?.uid)!)
            userRef?.setValue(["email": user?.email])
        }
    }
}

