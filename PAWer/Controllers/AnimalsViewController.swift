//
//  AnimalsViewController.swift
//  PAWer
//
//  Created by Denis Sorokin on 01/11/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import UIKit
import Firebase

class AnimalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: Userp!
    var ref: DatabaseReference!
    var animals = Array<Animal>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else {return}
        print("cu \(currentUser.uid)")
        user = Userp(user: currentUser)
        print("USER \(user.uid)")
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("animals")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell number \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New animal", message: "Add new animal", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else {return}
            print("self user \(String(describing: self?.user))")
            let animal = Animal(name: textField.text!, userId: (self?.user.uid)!)
            let animalRef = self?.ref.child(animal.name)
            animalRef?.setValue(animal.convertToDict())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
}
