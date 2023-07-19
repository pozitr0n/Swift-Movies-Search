//
//  FullScreenViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 27/06/2023.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var indexPathFromParentViewController: Int = Int()
    
    // Test
    var testArray: [Item] = Model().testArray
    
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
    
        fullScreenImageView.image = UIImage(named: testArray[indexPathFromParentViewController].testPic ?? "image_cover_144_203")
        
    }

}
