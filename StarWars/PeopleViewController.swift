//
//  PeopleViewController.swift
//  People
//
//  Created by Chi Nguyen on 3/19/18.
//  Copyright © 2018 Chi Nguyen. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
//    var people = ["Luke Skywalker", "Leia Organa", "Han Solo", "C-3PO", "R2-D2"]
    var people:[[String:String]] = [[String:String]]()
    let peopleURL = "http://swapi.co/api/people/"
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        print("back")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("people view Did Load")
        fetchPeopleFromAPI(apiURL: peopleURL)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]["name"]
        
        // return the cell so that it can be rendered
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "pplDetailSegue", sender: indexPath)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "pplDetailSegue", sender: indexPath)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PeopleDetailsVC
        var ind = sender as! IndexPath
        destination.birth = people[ind.row]["birth_year"]
        destination.gender = people[ind.row]["gender"]
        destination.mass = people[ind.row]["mass"]
        destination.name = people[ind.row]["name"]
    }
    
    func fetchPeopleFromAPI(apiURL: String) {
        StarWarsModel.getAllPeople(api: apiURL, completionHandler: {
            
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {

                    if let results = jsonResult["results"] {
                        
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        let resultsArray = results as! NSArray
                        
                        for res in 0...resultsArray.count - 1 {
//                            print(res, resultsArray.count)
                            let person = resultsArray[res] as! NSDictionary
                            self.people.append([:])
                            let l = self.people.count - 1
                            self.people[l]["name"] = person["name"] as? String
                            self.people[l]["gender"] = person["gender"] as? String
                            self.people[l]["mass"] = person["mass"] as? String
                            self.people[l]["birth_year"] = person["birth_year"] as? String
                        }
                        
                        
                        if let next = jsonResult["next"] {
                            if !(next is NSNull) {
                                self.fetchPeopleFromAPI(apiURL: next as! String)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
//                        print(self.people)
                    }
                }
            } catch {
                print(error)
            }
        })
        
    }
}

