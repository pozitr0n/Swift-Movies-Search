//
//  DetailsCollectionViewCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 27/06/2023.
//

import UIKit

class DetailsPreviewCollectionViewCell: UICollectionViewCell {
  
    // Setting the parameters
    static let identifier = "DetailsPreviewCell"
    private let imageDetailsImageViewCornerRadius: CGFloat = 5
    
    let tmdbAPI = TMDB_API()
    
    var imagePath: String? {
        
        didSet {
            
            guard let imagePath = self.imagePath else {
                return
            }
            
            guard let url = URL(string: Constants.imgTMDB_Address + imagePath) else {
                return
            }
            
            tmdbAPI.getSetPosters(withURL: url) { image in
                self.imageDetailsImageView.image = image
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
        imageDetailsImageView.image = nil
    }
    
    override func awakeFromNib() {
        imageDetailsImageView.layer.cornerRadius = imageDetailsImageViewCornerRadius
        imageDetailsImageView.clipsToBounds = true
    }
    
    @IBOutlet weak var imageDetailsImageView: UIImageView!

}
