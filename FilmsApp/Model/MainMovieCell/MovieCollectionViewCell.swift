//
//  MovieCollectionViewCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 18/06/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // Setting the parameters
    static let identifier = "MovieCell"
    private let moviePreviewImageViewCornerRadius: CGFloat = 10
    
    var data: Item? {
        
        didSet {
            guard data != nil else {
                return
            }
            
            if let pictureName = data?.testPic {
                moviePreviewImageView.image = UIImage(named: pictureName)
            } else {
                moviePreviewImageView.image = UIImage(named: "image_cover_144_203")
            }
            
            if let titleName = data?.testTitle {
                movieTitleLabel.text = titleName
            } else {
                movieTitleLabel.text = "No movie name"
            }
            
            if let yearName = data?.testYear {
                releaseYearLabel.text = String(yearName)
            } else {
                releaseYearLabel.text = "0000"
            }
            
            if let ratingName = data?.testRating {
                ratingLabel.text = String(ratingName)
            } else {
                ratingLabel.text = "0.0"
            }
            
        }
        
    }
    
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
    
}
