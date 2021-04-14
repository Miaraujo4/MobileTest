//
//  MovieListAPI.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import Foundation

protocol MovieListAPIProtocol {
    func getPopularMovies(completionHandler: @escaping(_ movies: [Movie]?, _ error: Bool) -> Void)
}

class MovieListAPI: MovieListAPIProtocol {
    init() {
    }

    func getPopularMovies(completionHandler: @escaping(_ movies: [Movie]?, _ error: Bool) -> Void) {

        let request = NSMutableURLRequest(url: NSURL(string: "http://api.tvmaze.com/shows")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"

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
                    let responseJSON: [Movie] = try JSONDecoder().decode([Movie].self, from: dataResponse)
                    completionHandler(responseJSON, false)
                } catch {
                    completionHandler(nil, true)
                }
            }
        })
        dataTask.resume()
    }
}
