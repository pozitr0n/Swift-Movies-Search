//
//  FavouriteMovieCell.swift
//  myMovies
//
//  Created by Raman Kozar on 18/07/2023.
//

import UIKit

class FavouriteMovieCell: UICollectionViewCell {

    // Setting the parameters
    static let identifier = "FavouriteMovieCell"
    private let moviePreviewImageViewCornerRadius: CGFloat = 10
    private let model = Model()
    let tmdbAPI = TMDB_API()
    var cellIndex: Int = Int()
    
    var data: LikedMovieObject? {
        
        didSet {
            
            guard let unwrFavouriteData = data, let url = URL(string: Constants.imgTMDB_Address + unwrFavouriteData.moviePicture) else {
                return
            }
            
            tmdbAPI.getSetPosters(withURL: url) { image in
                self.moviePreviewImageView.image = image
            }
            
            movieTitleLabel.text = unwrFavouriteData.movieTitle
            releaseYearLabel.text = String(unwrFavouriteData.movieYear)
            ratingLabel.text = String(unwrFavouriteData.movieRating)
            
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
    
    weak var delegateFavourite: FavouriteMoviesViewControllerDelegate?
    
    // Outlets
    //
    @IBOutlet weak var moviePreviewImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var deleteFromFavouriteButton: UIButton!
    
    @IBAction func deleteFromFavouriteMovies(_ sender: Any) {
        
        model.deleteLikedItem(at: cellIndex)
        delegateFavourite?.updateFavouriteMoviesViewController()
        
    }

}
