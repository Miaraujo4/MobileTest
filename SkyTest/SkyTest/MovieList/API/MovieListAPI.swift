//
//  MovieListAPI.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import Foundation

protocol MovieListAPIProtocol {
    func getPopularMovies(completionHandler: @escaping(_ ids: [String], _ error: Bool) -> Void)
    func getMovieDetail(by movieId: String, completionHandler: @escaping(_ movie: Movie?, _ error: Bool) -> Void)
}

class MovieListAPI: MovieListAPIProtocol {
    init() {
    }

    func getPopularMovies(completionHandler: @escaping(_ ids: [String], _ error: Bool) -> Void) {
        let headers = [
            "x-rapidapi-key": "d4a5ce9903msh9d0f15a87f3ebb3p1baa9ajsn1717ce0ff934",
            "x-rapidapi-host": "imdb8.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb8.p.rapidapi.com/title/get-most-popular-movies?homeCountry=US&purchaseCountry=US&currentCountry=US")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionHandler([String](), true)
            } else {
                guard
                    let dataResponse: Data = data,
                    let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
                    else {
                        completionHandler([String](), true)
                        return
                }
                do {
                    let responseJSON: [String] = try JSONDecoder().decode([String].self, from: dataResponse)
                    completionHandler(responseJSON, false)
                } catch {
                    completionHandler([String](), true)
                }
            }
        })
        dataTask.resume()
    }

    func getMovieDetail(by movieId: String, completionHandler: @escaping(_ movie: Movie?, _ error: Bool) -> Void) {
        let headers = [
            "x-rapidapi-key": "d4a5ce9903msh9d0f15a87f3ebb3p1baa9ajsn1717ce0ff934",
            "x-rapidapi-host": "imdb8.p.rapidapi.com"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb8.p.rapidapi.com/title/get-overview-details?tconst=\(movieId)&currentCountry=US")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionHandler(nil, true)
            } else {
                guard
                    let dataResponse: Data = data,
                    let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
                    else {
                        completionHandler(nil, true)
                        return
                }
                do {
                    let responseJSON: Movie = try JSONDecoder().decode(Movie.self, from: dataResponse)
                    completionHandler(responseJSON, false)
                } catch {
                    completionHandler(nil, true)
                }
            }
        })

        dataTask.resume()
    }
}
