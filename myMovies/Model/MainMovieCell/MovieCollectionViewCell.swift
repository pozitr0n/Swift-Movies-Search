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
    private var imgTMDB_Address = "https://image.tmdb.org/t/p/w500"
    let tmdbAPI = TMDB_API()
    
    var data: MovieObject? {
        
        didSet {
            
            guard let unwrData = data, let url = URL(string: imgTMDB_Address + unwrData.moviePicture) else {
                return
            }
            
            tmdbAPI.getSetPosters(withURL: url) { image in
                self.moviePreviewImageView.image = image
            }
            
            movieTitleLabel.text = unwrData.movieTitle
            releaseYearLabel.text = String(unwrData.movieYear)
            ratingLabel.text = String(unwrData.movieRating)
            
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
