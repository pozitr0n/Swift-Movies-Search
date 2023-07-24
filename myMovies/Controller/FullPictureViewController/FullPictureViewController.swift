//
//  FullPictureViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class FullPictureViewController: UIViewController {

    @IBOutlet weak var fullPictureCollectionView: UICollectionView!
    
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
            
        fullPictureCollectionView.dataSource = self
        fullPictureCollectionView.delegate = self
               
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullPictureCell.identifier, for: indexPath) as? FullPictureCell else {
            return UICollectionViewCell()
        }
        
        cell.fillTheImage()
        
        return cell
        
    }
    
}