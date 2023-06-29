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
    
    // Filling picture into details preview cell
    //
    func fillMoviePreviewIntoCell(_ pictureName: String?) {
        
        if let pictureName = pictureName {
            imageDetailsImageView.image = UIImage(named: pictureName)
        } else {
            imageDetailsImageView.image = UIImage(named: "image_cover_100_100")
        }
        
    }
    
}
