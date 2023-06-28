//
//  MoviewDetailsViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // Setting the parameters
    private let moviePosterImageViewCornerRadius: CGFloat = 10
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var imageGalleryCollection: UICollectionView!
    
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLayout()
        
        // Tests
        movieTitleLabel.text = "This Is The Favourite Movie!"
        releaseYearLabel.text = "2017"
        ratingLabel.text = "9.5"
        
    }
    
    // Constraints setting function
    //
    func setupLayout() {
        moviePosterImageView.layer.cornerRadius = moviePosterImageViewCornerRadius
        moviePosterImageView.clipsToBounds = true
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        
        
    }
    
    
}
