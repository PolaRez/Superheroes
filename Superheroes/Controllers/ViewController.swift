//
//  ViewController.swift
//  Superheroes
//
//  Created by Polina Reznik on 03/08/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchResultesTableView: UITableView!
    
    var superheroesManager = DataManager.shared
    var superheroesArray = [Superhero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultesTableView.dataSource = self
        self.searchResultesTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        if let searchText = searchField.text {
            if !searchText.isEmpty {
                superheroesManager.searchSuperheroBy(searchText) { [weak self] searchResultes, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    self?.superheroesArray = searchResultes!
                    DispatchQueue.main.async {
                        self?.searchResultesTableView.reloadData()
                    }
                }
                searchField.text = ""
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.searchResultesTableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        let superhero = superheroesArray[indexPath.row]
        cell.imageView?.image = nil
        cell.nameLabel.text = ""
        let id = superhero.id
        cell.identifier = id
        
        superheroesManager.image(superhero) { data, error in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    if (cell.identifier == id) {
                        cell.imageView?.image = image
                        cell.nameLabel.text = superhero.name
                    }
                }
            }
        }
        return cell
    }
}

