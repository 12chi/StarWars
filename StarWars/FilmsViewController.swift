//
//  FilmsViewController.swift
//  People
//
//  Created by Chi Nguyen on 3/19/18.
//  Copyright © 2018 Chi Nguyen. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {

    var films:[[String:String]] = [[String:String]]()
    let filmURL = "http://swapi.co/api/films/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("films view Did Load")
        fetchFilmsFromAPI()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)

        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = films[indexPath.row]["title"]
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "filmDetailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FilmDetailsVC
        var index = sender as! IndexPath
        
        destination.titleFld = films[index.row]["title"]
        destination.date = films[index.row]["date"]
        destination.director = films[index.row]["director"]
        destination.opening = films[index.row]["opening"]!.replacingOccurrences(of: "\r\n", with: " ")
//        print(destination.opening)
    }
    
    @IBAction func unwindToFilmList(sender: UIStoryboardSegue) {
        
    }
    
    func fetchFilmsFromAPI() {
        
        StarWarsModel.getAllFilms(api: filmURL, completionHandler: {
            
            // see: Swift closure expression syntax
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    if let results = jsonResult["results"] {
     
                        let resultsArray = results as! NSArray
                        
                        for res in 0...resultsArray.count - 1 {
                            let film = resultsArray[res] as! NSDictionary
                            self.films.append([:])
                            let f = self.films.count - 1
                            self.films[f]["title"] = film["title"] as? String
                            self.films[f]["date"] = film["release_date"] as? String
                            self.films[f]["director"] = film["director"] as? String
                            self.films[f]["opening"] = film["opening_crawl"] as? String
                        }
//                        print(self.films)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
    }
}
