//
//  MovieListViewController.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import UIKit

protocol MovieListViewControllerProtocol: AnyObject {
    func updateMovieList()
}

class MovieListViewController: UIViewController {

    // MARK: - UI Properties
    @IBOutlet weak var moviesListCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    // MARK: - Properties
    var viewModel: MovieListViewModel = MovieListViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cine SKY"
        activityIndicator.startAnimating()
        viewModel.getMovies()
        configCollectionView()
        viewModel.delegate = self
    }


    // MARK: - Functions
    func configCollectionView() {
        moviesListCollectionView.dataSource = self
        moviesListCollectionView.delegate = self
        let widthCell = (UIScreen.main.bounds.width / 2) - 16
        let heightCell = UIScreen.main.bounds.height * 0.35
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        moviesListCollectionView.collectionViewLayout = layout
        moviesListCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
}

extension MovieListViewController: MovieListViewControllerProtocol {
    func updateMovieList() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.activityIndicator.startAnimating()
            self.moviesListCollectionView.reloadData()
        }

    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(viewModel: viewModel, index: indexPath.row)
        return cell
    }

}
