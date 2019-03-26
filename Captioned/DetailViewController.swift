//
//  DetailViewController.swift
//  Captioned
//
//  Created by Michele Galvagno on 26/03/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: Properties and connections
    @IBOutlet var imageView: UIImageView!
    var selectedPicture: Picture?
    
    // MARK: Views management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedPicture?.image {
            let path = getDocumentsDirectory().appendingPathComponent(imageToLoad)
            imageView.image = UIImage(contentsOfFile: path.path)
            print(imageToLoad)
        } else {
            print("Image not found!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: Helper methods
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
