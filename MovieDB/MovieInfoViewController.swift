//
//  MovieInfoViewController.swift
//  MovieDB
//
//  Created by MCS Devices on 2/9/18.
//  Copyright © 2018 angel. All rights reserved.
//
//MoiveViewController to display the information of cell clicked

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var titl: String?
    var release:String?
    var overview:String?
    var rating:String?
    var image:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = titl
        releaseLabel.text = release
        overviewTextView.text = overview
        ratingLabel.text = "\(String(describing: rating!))/10"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
