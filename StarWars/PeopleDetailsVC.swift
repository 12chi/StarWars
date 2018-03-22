//
//  PeopleDetailsVC.swift
//  StarWars
//
//  Created by Chi Nguyen on 3/19/18.
//  Copyright © 2018 Chi Nguyen. All rights reserved.
//

import UIKit

class PeopleDetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    var name:String?
    var gender:String?
    var birth:String?
    var mass:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name!
        genderLabel.text = gender!
        massLabel.text = mass!
        birthLabel.text = birth!
        
        // Do any additional setup after loading the view.
    }

}
