//
//  MoviewDetailsViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var imageGalleryCollection: UICollectionView!
    
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
