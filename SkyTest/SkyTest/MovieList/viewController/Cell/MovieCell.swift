//
//  MovieCell.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    // MARK: - UI Properties
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(viewModel: MovieListViewModel, index: Int) {
        movieNameLabel.text = viewModel.movies[index].name
        if let url: URL = URL(string: viewModel.movies[index].image.original) {
            movieImage.load(url: url)
        }
    }

}
