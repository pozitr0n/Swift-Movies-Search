//
//  UpMenuCell.swift
//  myMovies
//
//  Created by Raman Kozar on 01/09/2023.
//

import UIKit
import DropDown

class UpMenuCell: DropDownCell {

    @IBOutlet var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
