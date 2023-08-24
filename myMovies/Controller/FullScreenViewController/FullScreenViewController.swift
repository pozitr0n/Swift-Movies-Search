//
//  FullScreenViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 27/06/2023.
//

import UIKit
import RealmSwift

class FullScreenViewController: UIViewController {

    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    // Setting the parameters
    let model = Model()
    let tmdbAPI = TMDB_API()
    let imgTMDB_Address = "https://image.tmdb.org/t/p/w500"
    var isFavorited: Bool = Bool()
    var detailIndexPath: Int = Int()
    var controllerType: ControllerType?
    var arrayHelper: Results<MovieObject>?
    let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFullMoviePoster()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Getting full movie poster from parent view controller
    //
    func getFullMoviePoster() {
    
        if controllerType == .main {
        
            if isFavorited == false {
                
                guard let unwrMoviePicture = self.arrayHelper?[self.detailIndexPath].moviePicture,
                      let posterURL = URL(string: self.imgTMDB_Address + unwrMoviePicture) else {
                    return
                }
                
                self.tmdbAPI.getSetPosters(withURL: posterURL) { image in
                    self.fullScreenImageView.image = image
                }
                
            } else if isFavorited == true {
                
                guard let currID = self.arrayHelper?[self.detailIndexPath].id else {
                    return
                }
                
                let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                
                if likedScope?.first != nil {
                    
                    guard let unwrMoviePicture = likedScope?.first?.moviePicture,
                          let posterURL = URL(string: self.imgTMDB_Address + unwrMoviePicture) else {
                        return
                    }
                    
                    self.tmdbAPI.getSetPosters(withURL: posterURL) { image in
                        self.fullScreenImageView.image = image
                    }
                    
                }
                
            }
            
        }
        
        if controllerType == .favourite {
        
            guard let unwrMoviePicture = self.model.likedMoviesObjects?[self.detailIndexPath].moviePicture,
                  let posterURL = URL(string: self.imgTMDB_Address + unwrMoviePicture) else {
                return
            }
            
            self.tmdbAPI.getSetPosters(withURL: posterURL) { image in
                self.fullScreenImageView.image = image
            }
            
        }
        
    }

}
