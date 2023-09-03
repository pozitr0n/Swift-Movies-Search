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
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        myImageView.contentMode = .scaleAspectFit
        
        if self.traitCollection.userInterfaceStyle == .dark {

            self.contentView.backgroundColor = .black

            
        } else {
            self.contentView.backgroundColor = .white
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
