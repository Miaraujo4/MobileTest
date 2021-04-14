//
//  MovieListViewModel.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import Foundation

class MovieListViewModel {

    // MARK: - Properties
    var api: MovieListAPIProtocol
    var movieIds: [String]
    var movies: [Movie]
    var didGetMovies: Bool

    // MARK: - Delegate
    var delegate: MovieListViewControllerProtocol?

    init(api: MovieListAPIProtocol = MovieListAPI()) {
        self.api = api
        self.movieIds = [String]()
        self.movies = [Movie]()
        self.didGetMovies = false
    }

    func getMovies() {
        api.getPopularMovies { [weak self] response, error in
            if !error {
                self?.movies = response ?? [Movie]()
                self?.delegate?.updateMovieList()
            }
        }
    }
}
