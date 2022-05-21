//
//  ViewController.swift
//  Project1
//
//  Created by John Doll on 12/24/21.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        //DispatchQueue.global(qos: .userInitiated).async {
            for item in items {
                if item.hasPrefix("nssl") {
                    // this is picture to load
                    self.pictures.append(item)
                }
            }
        //}
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pictures.count)
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PictureCell.")
        }

        let picture = pictures[indexPath.item]
//
        cell.imageView.image = UIImage(contentsOfFile: IndexPath.item)
        cell.imageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
//
//        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
//        cell.imageView.layer.borderWidth = 2
//        cell.imageView.layer.cornerRadius = 3
//        cell.layer.cornerRadius = 7

        return cell
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }

}

