//
//  LoadingApplicationViewController.swift
//  FilmsApp
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
        
        // reloading data if need
        if !Constants().apiKey.isEmpty {
            DispatchQueue.main.async {
                self.tmdbAPI.dataRequest(requestType: APIRequestParameters.popular)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        
            if !Constants().apiKey.isEmpty {
             
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
        view.backgroundColor = .white
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
