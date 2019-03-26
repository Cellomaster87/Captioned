//
//  ViewController.swift
//  Captioned
//
//  Created by Michele Galvagno on 26/03/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - Properties
    var captions = [String]()
    
    // MARK: - Actions
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Views Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100 {
            captions.append("\(i)")
        }
        
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return captions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Caption", for: indexPath)
        cell.textLabel?.text = captions[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImage = captions[indexPath.row]
            detailVC.title = captions[indexPath.row]
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}

