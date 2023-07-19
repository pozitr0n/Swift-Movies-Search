//
//  MoviewDetailsViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    // Test
    var testArrayPreview: [TestDetailPreviewModel] = TestDetailPreviewMethods().returnTestArray()
    var testArray: [Item] = Model().testArray
    var testFavouriteArray: [Item] = Model().showMoviesLiked()
    
    // Setting the parameters
    private let moviePosterImageViewCornerRadius: CGFloat = 10
    
    // Parameter for animation
    var transition: RoundingTransition = RoundingTransition()
    
    // Parameter from favourite view controller
    var cameFromFavourite: Bool = Bool()
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageGalleryCollection: UICollectionView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var moviewPreviewCollectionView: UICollectionView!
    @IBOutlet weak var previewCountLabel: UILabel!
    @IBOutlet weak var allThePreviewImagesButton: UIButton!
    
    var receivedIndex: Int = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupLayout()
        initializeDataSourceDelegates()
        getMovieInformationFromMainController()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationViewController = segue.destination as? FullScreenViewController else {
            return
        }
        
        // Moving to full screen (using animation)
        destinationViewController.transitioningDelegate = self
        destinationViewController.modalPresentationStyle = .custom
        destinationViewController.indexPathFromParentViewController = receivedIndex
        
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
    
    // Getting all the movie-information to this detail view controller
    //
    func getMovieInformationFromMainController() {
        
        if cameFromFavourite {
            
            moviePosterImageView.image = UIImage(named: testFavouriteArray[receivedIndex].testPic ?? "image_cover_144_203")
            movieTitleLabel.text = testFavouriteArray[receivedIndex].testTitle
            releaseYearLabel.text = testFavouriteArray[receivedIndex].testYear
            ratingLabel.text = testFavouriteArray[receivedIndex].testRating
            
        } else {
         
            moviePosterImageView.image = UIImage(named: testArray[receivedIndex].testPic ?? "image_cover_144_203")
            movieTitleLabel.text = testArray[receivedIndex].testTitle
            releaseYearLabel.text = testArray[receivedIndex].testYear
            ratingLabel.text = testArray[receivedIndex].testRating
            
        }
        
        // Test
        movieDescriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
        // Test
        previewCountLabel.text = String(testArrayPreview.count)
        
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        
        
    }
    
    @IBAction func allThePreviewImages(_ sender: Any) {
        
        
        
    }
    
    // Method for presenting view
    //
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionProfile = .show
        transition.start = moviePosterImageView.center
        transition.roundColor = UIColor.white
        
        return transition
        
    }
    
    // Method for closing view
    //
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionProfile = .cancel
        transition.start = moviePosterImageView.center
        transition.roundColor = UIColor.white
        
        return transition
        
    }
    
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArrayPreview.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsPreviewCollectionViewCell.identifier, for: indexPath) as? DetailsPreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.fillMoviePreviewIntoCell(testArrayPreview[indexPath.row].testPic)
        
        return cell
        
    }
    
}
