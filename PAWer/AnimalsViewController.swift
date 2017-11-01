//
//  AnimalsViewController.swift
//  PAWer
//
//  Created by Denis Sorokin on 01/11/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import UIKit

class AnimalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
