//
//  MovieViewCell.swift
//  MovieDB
//
//  Created by MCS Devices on 2/8/18.
//  Copyright © 2018 angel. All rights reserved.
//
// Custom movieviewcell class to display the information using xib
import UIKit

class MovieViewCell: UITableViewCell {
    static let nibName = "MovieViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func populateCell(movie:MovieModel){
        accessoryType = .disclosureIndicator
        
        
        
        titleLabel.text =  movie.title
        releaseLabel.text = movie.releaseDate
        overviewText.text = movie.overview

        guard let posterPath = movie.posterPath as String? else {
            return
        }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") as URL? else {
            return
        }
        
        self.imageIndicator.startAnimating()
        movieImageView.loadImageUsingCacheWithUrl(url:url, completion: {
            (success) in
            if success {
                self.imageIndicator.stopAnimating()
            }
        })
    }
    
}
