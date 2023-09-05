//
//  FullPictureViewController.swift
//  myMovies
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit
import RealmSwift

class FullPictureViewController: UIViewController {

    @IBOutlet weak var fullPictureCollectionView: UICollectionView!
    
    // Setting the parameters
    let model = Model()
    var moviePreviews: List<String>?
    var countTheElements: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDataSourceDelegates()
        initializeViewParameters()
        registerXIBCell()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
            
        fullPictureCollectionView.dataSource = self
        fullPictureCollectionView.delegate = self
               
    }
    
    // Method for initialization parameters
    //
    func initializeViewParameters() {
        
        if self.traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        }
        
        guard let previews = moviePreviews else {
            return
        }
        
        countTheElements = previews.count
        
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "FullPictureCell", bundle: nil)
        
        // registering xib-cell
        fullPictureCollectionView.register(customXIBCell, forCellWithReuseIdentifier: FullPictureCell.identifier)
        
        // reloading data
        DispatchQueue.main.async {
            self.fullPictureCollectionView.reloadData()
        }
        
    }

}

extension FullPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countTheElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullPictureCell.identifier, for: indexPath) as? FullPictureCell,
              let previews = self.moviePreviews else {
            return UICollectionViewCell()
        }
        
        cell.fillTheImage(partOtTheURL: previews[indexPath.row])
        
        return cell
        
    }
    
}
