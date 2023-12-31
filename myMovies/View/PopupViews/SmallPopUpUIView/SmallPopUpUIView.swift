//
//  SmallPopUpUIView.swift
//  myMovies
//
//  Created by Raman Kozar on 31/08/2023.
//

import UIKit
import SwiftEntryKit

class SmallPopUpUIView: UIView {
    
    let imageView = UIImageView()
    let fullNameLabel = UILabel()
    let actionButton = UIButton(type: .system)
    var apiKey: String = ""
    
    init(image: UIImage, name: String) {
        
        super.init(frame: UIScreen.main.bounds)
        
        imageView.image = image
        fullNameLabel.text = name
        apiKey = Constants().apiKey
        
        setupElements()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        SwiftEntryKit.transform(to: MyPopUpUIView(with: setupMessage()))
    }
    
    func setupMessage() -> EKPopUpMessage {
        
        let image = UIImage(named: "tmdb_icon")!.withRenderingMode(.alwaysTemplate)
        let title = apiKey
        let description =
        """
        You are using a personal session key for \
        the TMDB API. This is the unique key that you \
        received during the registration
        """
        
        let commonColour: EKColor
        if self.traitCollection.userInterfaceStyle == .dark {
            commonColour = .white
        } else {
            commonColour = .black
        }
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: commonColour, contentMode: .scaleAspectFit))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 25),
                                                                           color: .init(red: 34, green: 139, blue: 34),
                                                                      alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: UIFont.systemFont(ofSize: 15),
                color: commonColour,
                alignment: .center
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: UIFont.systemFont(ofSize: 15),
                    color: commonColour
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

// MARK: - Setup View
extension SmallPopUpUIView {
    
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
            fullNameLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -30)
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
