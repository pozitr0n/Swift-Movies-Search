//
//  DetailsCollectionViewCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 27/06/2023.
//

import UIKit

class DetailsPreviewCollectionViewCell: UICollectionViewCell {
  
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
