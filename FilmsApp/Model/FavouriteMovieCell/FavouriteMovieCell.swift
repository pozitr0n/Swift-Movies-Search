//
//  FavouriteMovieCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 18/07/2023.
//

import UIKit

class FavouriteMovieCell: UICollectionViewCell {

    // Setting the parameters
    static let identifier = "FavouriteMovieCell"
    private let moviePreviewImageViewCornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePreviewImageView.image = nil
    }
    
    override func awakeFromNib() {
        moviePreviewImageView.layer.cornerRadius = moviePreviewImageViewCornerRadius
        moviePreviewImageView.clipsToBounds = true
    }
    
    // Outlets
    //
    @IBOutlet weak var moviePreviewImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var deleteFromFavouriteButton: UIButton!
    
    // Filling all the information into preview favourite cell
    //
    func fillDataIntoFavouriteCell(_ item: Item) {
     
        if let pictureName = item.testPic {
            moviePreviewImageView.image = UIImage(named: pictureName)
        } else {
            moviePreviewImageView.image = UIImage(named: "image_cover_144_203")
        }
        
        if let titleName = item.testTitle {
            movieTitleLabel.text = titleName
        } else {
            movieTitleLabel.text = "No movie name"
        }
        
        if let yearName = item.testYear {
            releaseYearLabel.text = String(yearName)
        } else {
            releaseYearLabel.text = "0000"
        }
        
        if let ratingName = item.testRating {
            ratingLabel.text = String(ratingName)
        } else {
            ratingLabel.text = "0.0"
        }
        
    }
    
    @IBAction func deleteFromFavouriteMovies(_ sender: Any) {
        
        print("Test")
        
    }

}
