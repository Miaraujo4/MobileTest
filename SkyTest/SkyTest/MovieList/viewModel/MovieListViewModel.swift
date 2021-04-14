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

    init(api: MovieListAPIProtocol = MovieListAPI()) {
        self.api = api
        self.movieIds = [String]()
        self.movies = [Movie]()
        self.didGetMovies = false
    }

    func getMovies() {
        api.getPopularMovies { [weak self] response, error in
            if !error {
                response.forEach { movie in
                    let movieHelper: String = movie.replacingOccurrences(of: "/", with: "")
                        .replacingOccurrences(of: "title", with: "")
                    self?.movieIds.append(movieHelper)
                }
                self?.getMovieDetail(by: 49)//self?.movieIds.startIndex ?? 0)
            }
        }
    }

    func getMovieDetail(by index: Int) {
        if movieIds.indices.contains(index) {
            api.getMovieDetail(by: movieIds[index]) { [weak self] movie, error in
                if !error {
                    guard let movieResponse = movie else {
                        print("Error getting movie object")
                        return
                    }
                    self?.movies.append(movieResponse)
                    self?.getMovieDetail(by: index + 1)
                } else {
                    print("Error getting detail movie")
                }
            }
        } else {
            self.didGetMovies = true
        }
    }

}
