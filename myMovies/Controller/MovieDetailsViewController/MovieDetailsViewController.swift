//
//  MoviewDetailsViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit
import RealmSwift
import SwiftMessages

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    // Setting the parameters
    var moviePreviews: List<String>?
    var moviePreviewsImagesOriginal: [UIImage] = []
    var model = Model()
    let realm = try? Realm()
    
    var tmdbAPI = TMDB_API()
    var cameFromFavourite: Bool = Bool()
    
    // Setting the parameters
    private let moviePosterImageViewCornerRadius: CGFloat = 10
    
    // Parameter for animation
    var transition: RoundingTransition = RoundingTransition()
    
    weak var delegateFavourite: FavouriteMoviesViewControllerDelegate?
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageGalleryCollection: UICollectionView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var moviewPreviewCollectionView: UICollectionView!
    @IBOutlet weak var previewCountLabel: UILabel!
    @IBOutlet weak var allThePreviewImagesButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!
    
    var receivedIndex: Int = Int()
    var arrayHelper: Results<MovieObject>?
    var controllerType: ControllerType?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            self.setupLayout()
            self.initializeDataSourceDelegates()
            self.getMovieInformationFromMainController()
            
            self.getPreviewInformationFromMainController()
            self.moviewPreviewCollectionView.reloadData()

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationViewController = segue.destination as? FullScreenViewController else {
            return
        }
        
        // Moving to full screen (using animation)
        destinationViewController.transitioningDelegate = self
        destinationViewController.modalPresentationStyle = .custom
        
        destinationViewController.detailIndexPath = receivedIndex
        destinationViewController.isFavorited = cameFromFavourite
        destinationViewController.controllerType = controllerType
        destinationViewController.arrayHelper = arrayHelper
        
    }
    
    // Constraints setting function
    //
    func setupLayout() {
        
        moviePosterImageView.layer.cornerRadius = moviePosterImageViewCornerRadius
        moviePosterImageView.clipsToBounds = true
        movieDescriptionTextView.isUserInteractionEnabled = false
        
        setLikeButton()
        
    }
    
    // Setting "like button" when view controller opening
    //
    func setLikeButton() {
        
        if cameFromFavourite == false {
            likeButton.alpha = 0.5
            likeButton.tintColor = .lightGray
        } else {
            likeButton.alpha = 1
            likeButton.tintColor = .darkGray
        }
        
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
        
        if controllerType == .main {
         
            if self.cameFromFavourite == false {
                
                guard let unwrMoviePicture = self.arrayHelper?[self.receivedIndex].moviePicture,
                      let unwrPosterURL = URL(string: Constants.imgTMDB_Address + unwrMoviePicture) else {
                    return
                }
                
                self.tmdbAPI.getSetPosters(withURL: unwrPosterURL) { image in
                    self.moviePosterImageView.image = image
                }
                
                self.movieTitleLabel.text = self.arrayHelper?[self.receivedIndex].movieTitle
                self.releaseYearLabel.text = String(self.arrayHelper?[self.receivedIndex].movieYear ?? 0000)
                self.ratingLabel.text = String(self.arrayHelper?[self.receivedIndex].movieRating ?? 0)
                self.movieDescriptionTextView.text = self.arrayHelper?[self.receivedIndex].about
                
            } else if self.cameFromFavourite == true {
                
                guard let currID = self.arrayHelper?[self.receivedIndex].id else {
                    return
                }
                
                let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                
                if likedScope?.first != nil {
                    
                    guard let unwrMoviePicture = likedScope?.first?.moviePicture,
                          let unwrPosterURL = URL(string: Constants.imgTMDB_Address + unwrMoviePicture) else {
                        return
                    }
                    
                    self.tmdbAPI.getSetPosters(withURL: unwrPosterURL) { image in
                        self.moviePosterImageView.image = image
                    }
                    
                    self.movieTitleLabel.text = likedScope?.first?.movieTitle
                    self.releaseYearLabel.text = String(likedScope?.first?.movieYear ?? 0000)
                    self.ratingLabel.text = String(likedScope?.first?.movieRating ?? 0)
                    self.movieDescriptionTextView.text = likedScope?.first?.about
                    
                }
                
            }
            
        }
        
        if controllerType == .favourite {
            
            guard let unwrMoviePicture = self.model.likedMoviesObjects?[self.receivedIndex].moviePicture,
                  let unwrPosterURL = URL(string: Constants.imgTMDB_Address + unwrMoviePicture) else {
                return
            }
            
            self.tmdbAPI.getSetPosters(withURL: unwrPosterURL) { image in
                self.moviePosterImageView.image = image
            }
            
            self.movieTitleLabel.text = self.model.likedMoviesObjects?[self.receivedIndex].movieTitle
            self.releaseYearLabel.text = String(self.model.likedMoviesObjects?[self.receivedIndex].movieYear ?? 0000)
            self.ratingLabel.text = String(self.model.likedMoviesObjects?[self.receivedIndex].movieRating ?? 0)
            self.movieDescriptionTextView.text = self.model.likedMoviesObjects?[self.receivedIndex].about
            
        }
        
    }
    
    func getPreviewInformationFromMainController() {
        
        if controllerType == .main {
         
            if self.cameFromFavourite == false {
                
                self.moviePreviews = self.arrayHelper?[self.receivedIndex].moviePreviews
                
            } else if self.cameFromFavourite == true {
                
                guard let currID = self.arrayHelper?[self.receivedIndex].id else {
                    return
                }
                
                let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                
                if likedScope?.first != nil {
                    
                    self.moviePreviews = likedScope?.first?.moviePreviews
                    
                }
                
            }
            
        }
        
        if controllerType == .favourite {
            
            self.moviePreviews = self.model.likedMoviesObjects?[self.receivedIndex].moviePreviews
            
        }
        
        guard let previews = self.moviePreviews else {
            return
        }
        
        previewCountLabel.text = String(previews.count)
        
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        // Later
    }
    
    @IBAction func allThePreviewImages(_ sender: Any) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MoviePicturesViewControllerID") as? MoviePicturesViewController else {
            return
        }
        
        destinationViewController.moviePreviews = moviePreviews
        destinationViewController.movieName = movieTitleLabel.text
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        
        model.updateFavouriteMovie(at: receivedIndex, controllerType: controllerType!, gettingArrayHelper: arrayHelper)
        cameFromFavourite = !cameFromFavourite
        setLikeButton()
        delegateFavourite?.updateFavouriteMoviesViewController()
        
        startWarningAlert(favouriteMovie: cameFromFavourite)
        
        if !cameFromFavourite && controllerType == .favourite {
                       
            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewControllerID")
            homeController.modalTransitionStyle = .crossDissolve
            homeController.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(homeController, animated: false)
            
        }
        
    }
    
    @IBAction func playVideoAction(_ sender: Any) {
        
        let playingVideoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayingVideoViewControllerID") as? PlayingVideoViewController
        
        var arrayOfTrailers: [String] = []
        var movieTitle: String = ""
        
        if controllerType == .main {
         
            if self.cameFromFavourite == false {
                
                guard let arrayTrailers = self.arrayHelper?[self.receivedIndex].movieTrailers else {
                    return
                }
                
                arrayOfTrailers = Array(arrayTrailers)
                
                guard let title = self.arrayHelper?[self.receivedIndex].movieTitle else {
                    return
                }
                
                movieTitle = title
                
            } else if self.cameFromFavourite == true {
                
                guard let currID = self.arrayHelper?[self.receivedIndex].id else {
                    return
                }
                
                let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                
                if likedScope?.first != nil {
                    
                    guard let arrayTrailers = likedScope?.first?.movieTrailers else {
                        return
                    }
                    
                    arrayOfTrailers = Array(arrayTrailers)
                    
                    guard let title = likedScope?.first?.movieTitle else {
                        return
                    }
                    
                    movieTitle = title
                    
                }
                
            }
            
        }
        
        if controllerType == .favourite {
            
            guard let arrayTrailers = self.model.likedMoviesObjects?[self.receivedIndex].movieTrailers else {
                return
            }
            
            arrayOfTrailers = Array(arrayTrailers)
            
            guard let title = self.model.likedMoviesObjects?[self.receivedIndex].movieTitle else {
                return
            }
            
            movieTitle = title
            
        }
    
        playingVideoViewController?.arrayOfVideosYoutubeID = arrayOfTrailers
        playingVideoViewController?.titleMovie = movieTitle
        
        guard let playingVideoViewController = playingVideoViewController else {
            return
        }
        
        self.navigationController?.present(playingVideoViewController, animated: true)
        
    }
    
    func startWarningAlert(favouriteMovie: Bool) {
     
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        var iconText: String = ""
        var title: String = ""
        var body: String = ""
        
        if favouriteMovie {
            
            iconText = ["🤩"].randomElement()!
            title = "WOW"
            body = "Movie has been added to favourite!"
            
        } else {
         
            iconText = ["😥"].randomElement()!
            title = "Ohh"
            body = "You don't like the movie anymore"
            
        }
        
        warning.configureContent(title: title, body: body, iconText: iconText)
        warning.button?.isHidden = true
        
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        
        SwiftMessages.show(config: warningConfig, view: warning)
        
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
        
        guard let previews = self.moviePreviews else {
            return 0
        }
        
        return previews.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsPreviewCollectionViewCell.identifier, for: indexPath) as? DetailsPreviewCollectionViewCell,
              let previews = self.moviePreviews else {
            return UICollectionViewCell()
        }
        
        cell.imagePath = previews[indexPath.row]
        
        return cell
        
    }
    
}
