//
//  SmallPopupUIView.swift
//  myMovies
//
//  Created by Raman Kozar on 31/08/2023.
//

import UIKit
import SwiftEntryKit

class SmallPopupUIView: UIView {
    
    let imageView = UIImageView()
    let fullNameLabel = UILabel()
    let actionButton = UIButton(type: .system)
    var apiKey: String = ""
    
    init(image: UIImage, name: String) {
        
        super.init(frame: UIScreen.main.bounds)
        
        imageView.image = image
        fullNameLabel.text = name
        
        DispatchQueue.main.async {
            self.apiKey = Constants().apiKey
        }
        
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        SwiftEntryKit.transform(to: MyPopupUIView(with: setupMessage()))
    }
    
    func setupMessage() -> EKPopUpMessage {
        
        let image = UIImage(named: "icon_tmdb")!.withRenderingMode(.alwaysTemplate)
        let title = apiKey
        let description =
        """
        You are using a personal session key \
        for the TMDB API. This is the unique key \
        you received during registration
        """
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: .black, contentMode: .scaleAspectFit))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24),
                                                                      color: .black,
                                                                      alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: UIFont.systemFont(ofSize: 15),
                color: .black,
                alignment: .center
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: UIFont.systemFont(ofSize: 15),
                    color: .black
                )
            ),
            backgroundColor: .init(UIColor.systemOrange),
            highlightedBackgroundColor: .clear
        )
        
        let message = EKPopUpMessage(themeImage: themeImage, title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        return message
        
    }
    
}

extension SmallPopupUIView {
    
    func setupElements() {
        
        fullNameLabel.numberOfLines = 0
        
        fullNameLabel.font = UIFont.init(name: "Helvetica", size: 13)
        
        actionButton.setTitle("More info", for: .normal)
        actionButton.backgroundColor = .systemOrange
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.layer.cornerRadius = 15
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
    }
    
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(fullNameLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            fullNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2), // because of the shadows
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            actionButton.heightAnchor.constraint(equalToConstant: 30),
            actionButton.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 21).isActive = true
        
    }
    
}
