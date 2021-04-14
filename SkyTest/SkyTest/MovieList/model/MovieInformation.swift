//
//  MovieInformation.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 8/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import Foundation

struct MovieInformation: Decodable {
    var title: String
    var year: Int
    var image: MovieImageDetail
}
