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
        imageView.image = UIImage(named: "logo")
        
        return imageView
        
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        setupLayout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {

            let mainViewController = MainViewController()
            mainViewController.modalTransitionStyle = .crossDissolve
            mainViewController.modalPresentationStyle = .fullScreen
            
            // need to do pushViewController

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
        view.backgroundColor = .lightGray
        view.addSubview(imageView)
    }

    private func animateStartOfApplication() {

        UIView.animate(withDuration: 1, animations: {

            let size = self.view.frame.size.width * 2
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size

            self.imageView.frame = CGRect(x: -(xPosition / 2), y: yPosition / 2, width: size, height: size)

        })

        UIView.animate(withDuration: 1.2, animations: {
            self.imageView.alpha = 0
        })

    }

}
