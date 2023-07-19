//
//  FavouriteMoviesViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {

    @IBOutlet weak var favouriteMoviesCollectionView: UICollectionView!
    
    // Test
    var testFavouriteArray: [Item] = Model().showMoviesLiked()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeDataSourceDelegates()
        registerXIBCell()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
        	
        favouriteMoviesCollectionView.dataSource = self
        favouriteMoviesCollectionView.delegate = self
               
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "FavouriteMovieCell", bundle: nil)
        
        favouriteMoviesCollectionView.register(customXIBCell, forCellWithReuseIdentifier: FavouriteMovieCell.identifier)
        favouriteMoviesCollectionView.reloadData()
        
    }

}

extension FavouriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testFavouriteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = favouriteMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: FavouriteMovieCell.identifier, for: indexPath) as? FavouriteMovieCell else {
            return UICollectionViewCell()
        }
        
        cell.fillDataIntoFavouriteCell(testFavouriteArray[indexPath.item])
        
        return cell
        
    }
    
}
