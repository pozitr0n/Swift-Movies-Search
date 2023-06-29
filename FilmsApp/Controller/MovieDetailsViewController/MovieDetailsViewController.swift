//
//  MoviewDetailsViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // Test
    var testArray: [TestDetailPreviewModel] = TestDetailPreviewMethods().returnTestArray()
    
    // Setting the parameters
    private let moviePosterImageViewCornerRadius: CGFloat = 10
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageGalleryCollection: UICollectionView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var moviewPreviewCollectionView: UICollectionView!
    @IBOutlet weak var previewCountLabel: UILabel!
    @IBOutlet weak var allThePreviewImagesButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLayout()
        initializeDataSourceDelegates()
        
        // Test
        movieTitleLabel.text = "Inception Warner Bros."
        releaseYearLabel.text = "2010"
        ratingLabel.text = "9.5"
        movieDescriptionTextView.text = "Cobb and Arthur are extractor who perform corporate espionage using experimental dream-sharing technology to infiltrate their targets' subconscious and extract information. Their latest target, Saito, is impressed with Cobb's ability to layer multiple dreams within each other. He offers to hire Cobb for the supposedly impossible job of implanting an idea into a person's subconscious; performing inception on Robert, the son of Saito's competitor Maurice Fischer, with the idea to dissolve his father's company. Saito promises to clear Cobb's criminal status, allowing him to return home to his children. Cobb accepts the offer and assembles his team: a forger named Eames, a chemist named Yusuf, and a college student named Ariadne. Ariadne is tasked with designing the dream's architecture, something Cobb himself cannot do for fear of being sabotaged by his mind's projection of his late wife Mal. Maurice dies, and the team sedates Robert into a three-layer shared dream on an airplane to America. Time on each layer runs slower than the layer above, with one member staying behind on each to perform a music-synchronized kick to awaken dreamers on all three levels simultaneously. The team abducts Robert in a city on the first level, but they are attacked by his trained subconscious projections. After Saito is wounded, Cobb reveals that while dying in the dream would normally awaken dreamers, Yusuf's sedatives will instead send them into Limbo: a world of infinite subconscious. Eames impersonates Robert's godfather, Peter Browning, to introduce the idea of an alternate will to dissolve the company. Cobb tells Ariadne that he and Mal entered Limbo while experimenting with dream-sharing, experiencing fifty years in one night due to the time dilation with reality."
        previewCountLabel.text = String(testArray.count)
        
    }
    
    // Constraints setting function
    //
    func setupLayout() {
        
        moviePosterImageView.layer.cornerRadius = moviePosterImageViewCornerRadius
        moviePosterImageView.clipsToBounds = true
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
        
        moviewPreviewCollectionView.dataSource = self
        moviewPreviewCollectionView.delegate = self
        
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        
        
    }
    
    @IBAction func allThePreviewImages(_ sender: Any) {
        
        
        
    }
    
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsPreviewCollectionViewCell.identifier, for: indexPath) as? DetailsPreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.fillMoviePreviewIntoCell(testArray[indexPath.row].testPic)
        
        return cell
        
    }
    
}
