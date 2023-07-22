//
//  MoviePicturesViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MoviePicturesViewController: UIViewController {

    @IBOutlet weak var moviePicturesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDataSourceDelegates()
        registerXIBCell()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
            
        moviePicturesCollectionView.dataSource = self
        moviePicturesCollectionView.delegate = self
               
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "MoviePicturesCell", bundle: nil)
        
        // registering xib-cell
        moviePicturesCollectionView.register(customXIBCell, forCellWithReuseIdentifier: MoviePicturesCell.identifier)
        
        // reloading data
        moviePicturesCollectionView.reloadData()
        
    }

}

extension MoviePicturesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePicturesCell.identifier, for: indexPath) as? MoviePicturesCell else {
            return UICollectionViewCell()
        }
        
        cell.fillTheImage()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "FullPictureViewControllerID") as? FullPictureViewController else {
            return
        }
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}
