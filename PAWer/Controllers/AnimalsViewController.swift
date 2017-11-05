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
        user = Userp(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("animals")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] (snapshot) in
            var _animals = Array<Animal>()
            for animal in snapshot.children{
                let animal = Animal(snapshot: animal as! DataSnapshot)
                _animals.append(animal)
            }
            self?.animals = _animals
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let animal = animals[indexPath.row]
        let animalName = animal.name
        let isCompleted = animal.completed
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
       
        cell.textLabel?.text = animalName
        toggleCompletion(cell, isCompleted: isCompleted)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animal = animals[indexPath.row]
            animal.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        let animal = animals[indexPath.row]
        let isCompleted = !animal.completed
        toggleCompletion(cell, isCompleted: isCompleted)
        
        animal.ref?.updateChildValues(["completed": isCompleted])
    }
    
    func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool){
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New animal", message: "Add new animal", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else {return}
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
