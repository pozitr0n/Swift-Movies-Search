//
//  LoadingApplicationViewController.swift
//  myMovies
//
//  Created by Raman Kozar on 24/07/2023.
//

import Foundation
import UIKit

// Start application view controller for the beautiful animation
//
class LoadingApplicationViewController: UIViewController {

    private let imageView: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.image = UIImage(named: "appIconDarkLaunchScreen")
        
        return imageView
        
    }()
    
    let tmdbAPI = TMDB_API()
     
    override func viewDidLoad() {

        super.viewDidLoad()
        setupLayout()
        
        let key = Constants().apiKey
        
        // reloading data if need
        if !key.isEmpty {
            
            let operationQueue = OperationQueue()

            let oneOperation = BlockOperation {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.latest, apiKey: key)
            }

            let twoOperation = BlockOperation {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.popular, apiKey: key)
            }

            let threeOperation = BlockOperation {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.nowPlaying, apiKey: key)
            }

            let fourOperation = BlockOperation {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.topRated, apiKey: key)
            }
            
            let fiveOperation = BlockOperation {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.upcoming, apiKey: key)
            }
            
            twoOperation.addDependency(oneOperation)
            threeOperation.addDependency(twoOperation)
            fourOperation.addDependency(threeOperation)
            fiveOperation.addDependency(fourOperation)
            
            operationQueue.addOperations([
                oneOperation,
                twoOperation,
                threeOperation,
                fourOperation,
                fiveOperation
            ], waitUntilFinished: false)
            
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        
            if !key.isEmpty {
             
                let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewControllerID")
                homeController.modalTransitionStyle = .crossDissolve
                homeController.modalPresentationStyle = .fullScreen
                
                self.navigationController?.pushViewController(homeController, animated: false)
                
            } else {
           
                let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID")
            
                let navigationViewController = UINavigationController(rootViewController: homeController)
                navigationViewController.modalTransitionStyle = .crossDissolve
                navigationViewController.modalPresentationStyle = .fullScreen
                
                self.present(navigationViewController, animated: false)
                
            }
            
        })

    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        imageView.center = view.center

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.animateStartOfApplication()
        })

    }

    func setupLayout() {
        
        if self.traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(imageView)
        
    }

    private func animateStartOfApplication() {

        UIView.animate(withDuration: 1, animations: {

            let size = self.view.frame.size.width * 10
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size

            self.imageView.frame = CGRect(x: -(xPosition / 2), y: yPosition / 2, width: size, height: size)

        })

        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        })

    }

}
