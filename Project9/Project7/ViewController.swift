//
//  ViewController.swift
//  Project7
//
//  Created by John Doll on 5/19/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filtered = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    // we're OK to parse!
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Enter word to filter by", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        let submitFilter = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] action in
            guard let filter = ac?.textFields?[0].text else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                self?.submit(filter)
            }
        }
        ac.addAction(submitFilter)
        present(ac, animated: true)
    }
    
    func submit(_ filter: String) {
        self.filtered = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        for petition in self.petitions {
            if (petition.title.contains(filter)) {
                self.filtered.insert(petition, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                DispatchQueue.main.async {
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                }
                
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func credits() {
        let ac = UIAlertController(title: "Credits", message: "Data originates from We The People API", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filtered = petitions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filtered[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filtered[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

