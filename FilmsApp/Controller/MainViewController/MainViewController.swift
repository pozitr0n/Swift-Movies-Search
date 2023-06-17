//
//  ViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MainViewController: UIViewController {

    // Outlets
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeDataSourceDelegates()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        moviesSearchBar.delegate = self
        
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

