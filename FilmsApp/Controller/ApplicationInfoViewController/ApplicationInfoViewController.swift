//
//  ApplicationInfoViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 23/07/2023.
//

import UIKit

class ApplicationInfoViewController: UIViewController {

    @IBOutlet weak var mainInformationLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupLayout()
        fillAuthorInfo()
        
    }
    
    // Setting up the layout
    //
    func setupLayout() {
        
        DispatchQueue.main.async {
            self.authorImageView.layer.cornerRadius = self.authorImageView.bounds.size.width / 2.0
            self.authorImageView.clipsToBounds = true
        }
        
    }
    
    // Filling the information on the controller
    //
    func fillAuthorInfo() {
        
        let mainInformationLabelText = """
        Application for watching
        movies information
        using TMDb API. Version 1.0
        """
        
        let authorDescriptionLabelText = """
        Application author
        Raman Kozar
        """
        
        mainInformationLabel.text = mainInformationLabelText
        authorDescriptionLabel.text = authorDescriptionLabelText
        
    }
    
}
