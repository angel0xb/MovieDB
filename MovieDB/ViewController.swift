//
//  ViewController.swift
//  MovieDB
//
//  Created by MCS Devices on 2/8/18.
//  Copyright © 2018 angel. All rights reserved.
//
// Main view controller contains search field and tableview that displays results

import UIKit

class ViewController: UIViewController {
    
    var myMovieArray: [MovieModel] = []
    var networkRequests: [Any?] = []
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchMovie(_ sender: Any) {
        let myNetManager = NetworkManager()
        networkRequests.append( myNetManager)
        
        myNetManager.delegate = self as NetworkManagerDelegate
        if let search = searchField.text{
            myNetManager.downloadMovies(search: search)
        }
        view.endEditing(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib(nibName: MovieViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieViewCell.nibName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieInfo"{
            if let destinationViewController = segue.destination as? MovieInfoViewController, let indexRow = tableView.indexPathForSelectedRow?.row{
                let movie = myMovieArray[indexRow]
                destinationViewController.titl = movie.title
                destinationViewController.release = movie.releaseDate
                destinationViewController.overview = movie.overview
                destinationViewController.rating = "\(movie.voteAverage)"
                destinationViewController.image = movie.posterPath
                
                DispatchQueue.main.async {
                    guard let posterPath = movie.posterPath as String? else {
                        return
                    }
                    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") as URL? else {
                        return
                    }
                    if let data = try? Data(contentsOf: url){
                        if let image: UIImage = UIImage(data: data){
                            destinationViewController.movieImageView.image = image
                        }
                    }
                    
                    }
            }
        }
    }
}
extension ViewController: NetworkManagerDelegate{
    func didDownloadMovies(movieArray: [MovieModel]) {
        myMovieArray = movieArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieInfo", sender: self)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.nibName, for: indexPath) as! MovieViewCell
        let movie = myMovieArray[indexPath.row]
        
        
        
        DispatchQueue.main.async {
            cell.populateCell(movie: movie)
        }
        

        return cell
    }
}
