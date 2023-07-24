//
//  FullPictureCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 22/07/2023.
//

import UIKit

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
    
    func fillTheImage() {
        
        fullPictureImageView.image = UIImage(named: "image1")
        
    }

}
