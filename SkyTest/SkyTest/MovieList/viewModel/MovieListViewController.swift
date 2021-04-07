//
//  MovieListViewController.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 7/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - UI Properties
    @IBOutlet weak var moviesListCollectionView: UICollectionView!


    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cine SKY"
        moviesListCollectionView.dataSource = self
        moviesListCollectionView.delegate = self
        moviesListCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (UIScreen.main.bounds.width / 2)
        let heightCell = UIScreen.main.bounds.height * 0.35
        return CGSize(width: widthCell, height: heightCell)
    }
}
