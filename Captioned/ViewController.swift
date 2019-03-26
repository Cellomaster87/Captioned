//
//  ViewController.swift
//  Captioned
//
//  Created by Michele Galvagno on 26/03/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Properties
    var pictures = [Picture]()
    
    // MARK: - Actions
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // setup of image picker
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
                picker.mediaTypes = availableMediaTypes
                picker.sourceType = .camera
            }
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Views Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Captioned"
        load()
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Caption", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].image
        cell.detailTextLabel?.text = pictures[indexPath.row].caption
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedPicture = pictures[indexPath.row]
            detailVC.title = pictures[indexPath.row].caption
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    // MARK: - ImagePicker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(caption: "Caption", image: imageName)
        pictures.append(picture)
        save()
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper methods
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        } else {
            print("Failed to save the pictures")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                print("Failed to load pictures.")
            }
        }
    }
}

