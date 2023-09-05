//
//  FullPictureCell.swift
//  myMovies
//
//  Created by Raman Kozar on 22/07/2023.
//

import UIKit
import SDWebImage

class FullPictureCell: UICollectionViewCell {

    // Setting the parameters
    static let identifier = "FullPictureCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullPictureImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fullPictureImageView.clipsToBounds = true
    }
    
    @IBOutlet weak var fullPictureImageView: UIImageView!
    
    func fillTheImage(partOtTheURL: String?) {
        
        guard let imagePath = partOtTheURL else {
            return
        }
        
        guard let url = URL(string: Constants.imgTMDB_Address_Original + imagePath) else {
            return
        }
        
        fullPictureImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: "image_cover_144_203"),
                                        options: [.continueInBackground, .progressiveLoad],
                                        completed: nil)
        
    }

}
