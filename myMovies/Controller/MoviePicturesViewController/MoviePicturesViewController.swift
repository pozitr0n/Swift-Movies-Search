//
//  MoviePicturesViewController.swift
//  myMovies
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit
import RealmSwift

class MoviePicturesViewController: UIViewController {

    @IBOutlet weak var movieNameFull: UILabel!
    @IBOutlet weak var moviePicturesCollectionView: UICollectionView!
    @IBOutlet weak var currentCounter: UILabel!
    @IBOutlet weak var previewMovieLabel: UILabel!
    
    // Setting the parameters
    let model = Model()
    var moviePreviews: List<String>?
    var movieName: String?
    var countTheElements: Int = 0
    private let cornerRadius: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDataSourceDelegates()
        registerXIBCell()
        initializeViewParameters()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
            
        moviePicturesCollectionView.dataSource = self
        moviePicturesCollectionView.delegate = self
               
    }
    
    // Method for initialization parameters
    //
    func initializeViewParameters() {
        
        currentCounter.layer.masksToBounds = true
        currentCounter.layer.cornerRadius = cornerRadius
        
        movieNameFull.layer.masksToBounds = true
        movieNameFull.layer.cornerRadius = cornerRadius
        
        if self.traitCollection.userInterfaceStyle == .dark {
            
            self.view.backgroundColor = .black
            
            previewMovieLabel.textColor = .white
            previewMovieLabel.backgroundColor = .black
            
            movieNameFull.textColor = .white
            movieNameFull.backgroundColor = .black
            
            moviePicturesCollectionView.backgroundColor = .black
            
            currentCounter.textColor = .white
            currentCounter.backgroundColor = .black
            currentCounter.layer.borderColor = UIColor.white.cgColor
            currentCounter.layer.borderWidth = 2.0
            
        }
        
        guard let movieNameUnwr = movieName else {
            return
        }
        
        movieNameFull.text =  "\(movieNameUnwr)"
        
        guard let previews = moviePreviews else {
            return
        }
        
        countTheElements = previews.count
        
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "MoviePicturesCell", bundle: nil)
        
        // registering xib-cell
        moviePicturesCollectionView.register(customXIBCell, forCellWithReuseIdentifier: MoviePicturesCell.identifier)
        
        // reloading data
        DispatchQueue.main.async {
            self.moviePicturesCollectionView.reloadData()
        }
        
    }

}

extension MoviePicturesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countTheElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePicturesCell.identifier, for: indexPath) as? MoviePicturesCell,
              let previews = self.moviePreviews else {
            return UICollectionViewCell()
        }
        
        cell.imagePath = previews[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "FullPictureViewControllerID") as? FullPictureViewController else {
            return
        }
        
        destinationViewController.moviePreviews = moviePreviews
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        for cell in collectionView.visibleCells {
            
            let indexPath = collectionView.indexPath(for: cell)
            
            guard let _indexPath = indexPath else {
                return
            }
            
            currentCounter.text = "\(_indexPath.row + 1) / \(countTheElements)"
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        for cell in collectionView.visibleCells {
            
            let indexPath = collectionView.indexPath(for: cell)
            
            guard let _indexPath = indexPath else {
                return
            }
            
            currentCounter.text = "\(_indexPath.row + 1) / \(countTheElements)"
            
        }
        
    }
    
}
