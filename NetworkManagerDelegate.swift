//
//  NetworkManagerDelegate.swift
//  MovieDB
//
//  Copyright © 2018 angel. All rights reserved.
//
// to delegate populate array in main ViewController

import Foundation

protocol NetworkManagerDelegate: class {
    
    func didDownloadMovies(movieArray:[MovieModel])
    
}
