//
//  FavouriteMoviesViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {

    @IBOutlet weak var favouriteMoviesCollectionView: UICollectionView!
    
    // Setting the parameters
    let model = Model()
    
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
        
        // registering xib-cell
        favouriteMoviesCollectionView.register(customXIBCell, forCellWithReuseIdentifier: FavouriteMovieCell.identifier)
        
        // reloading data
        DispatchQueue.main.async {
            self.favouriteMoviesCollectionView.reloadData()
        }
        
    }

}

extension FavouriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.likedMoviesObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = favouriteMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: FavouriteMovieCell.identifier, for: indexPath) as? FavouriteMovieCell,
            
                let likedMovieItem = model.likedMoviesObjects?[indexPath.row] else {
            
                return UICollectionViewCell()
            
        }
        
        cell.data = likedMovieItem
        cell.cellIndex = indexPath.row
        cell.delegateFavourite = self
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewControllerID") as? MovieDetailsViewController else {
            return
        }
        
        destinationViewController.receivedIndex = indexPath.row
        destinationViewController.cameFromFavourite = true
        destinationViewController.delegateFavourite = self
        destinationViewController.controllerType = .favourite
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}

extension FavouriteMoviesViewController: FavouriteMoviesViewControllerDelegate {
    
    func updateFavouriteMoviesViewController() {
        DispatchQueue.main.async {
            self.favouriteMoviesCollectionView.reloadData()
        }
    }
    
}
