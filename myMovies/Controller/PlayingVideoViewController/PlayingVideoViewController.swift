//
//  PlayingVideoViewController.swift
//  myMovies
//
//  Created by Raman Kozar on 03/09/2023.
//

import UIKit
import YoutubePlayer_in_WKWebView

class PlayingVideoViewController: UIViewController, WKYTPlayerViewDelegate {

    @IBOutlet var playerView: WKYTPlayerView!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var arrayOfVideosYoutubeID: [String]?
    var titleMovie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            
            self.view.backgroundColor = .black
            
            movieTitle.textColor = .white
            movieTitle.backgroundColor = .black
            
            picker.tintColor = .white
            picker.backgroundColor = .black
            
        }
        
        initializeDataSourceDelegates()
        
        guard let titleMovie = titleMovie else {
            return
        }
        
        movieTitle.text = "\(titleMovie) - Trailers"
        
        guard let arrOfMovies = arrayOfVideosYoutubeID else {
            return
        }
        
        if !arrOfMovies.isEmpty {
            playerView.load(withVideoId: arrOfMovies[0], playerVars: ["playsinline" : 1])
        }
            
    }
    
    func initializeDataSourceDelegates() {
        
        picker.delegate = self
        picker.dataSource = self
        
        playerView.delegate = self
        
    }
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }

}

extension PlayingVideoViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let arrayOfVideosYoutubeID = arrayOfVideosYoutubeID else {
            return 0
        }
        
        return arrayOfVideosYoutubeID.count
        
    }
    
}

extension PlayingVideoViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Trailer to the movie - \(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let arrayOfVideosYoutubeID = arrayOfVideosYoutubeID else {
            return
        }
        
        playerView.load(withVideoId: arrayOfVideosYoutubeID[row], playerVars: ["playsinline" : 1])
        
    }
    
}
