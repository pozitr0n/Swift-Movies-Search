//
//  MoviePicturesCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 22/07/2023.
//

import UIKit

class MoviePicturesCell: UICollectionViewCell {

    // Setting the parameters
    static let identifier = "MoviePicturesCell"
    private let moviePictureImageViewCornerRadius: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePictureImageView.image = nil
    }
    
    override func awakeFromNib() {
        moviePictureImageView.layer.cornerRadius = moviePictureImageViewCornerRadius
        moviePictureImageView.clipsToBounds = true
    }
    
    @IBOutlet weak var moviePictureImageView: UIImageView!
    
    func fillTheImage() {
        
        moviePictureImageView.image = UIImage(named: "image1")
        
    }

}
