//
//  FilmDetailsVC.swift
//  StarWars
//
//  Created by Chi Nguyen on 3/20/18.
//  Copyright © 2018 Chi Nguyen. All rights reserved.
//

import UIKit

class FilmDetailsVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var OpeningLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var titleFld:String?
    var date:String?
    var director:String?
    var opening:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleFld!
        OpeningLabel.text = opening!
        directorLabel.text = director!
        releaseDateLabel.text = date!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
