//
//  SideMenuItemCell.swift
//  FilmsApp
//
//  Created by Raman Kozar on 19/07/2023.
//

import UIKit

final class SideMenuItemCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }

    private var itemIcon: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .darkGray
       
        return imageView
        
    }()

    private var itemLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: SideMenuItemCell.identifier)
        configureView()
        
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configureView()
        
    }

    // Method for configuring view
    //
    private func configureView() {
        
        contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        contentView.addSubview(itemIcon)
        contentView.addSubview(itemLabel)
        
    }

    // Method for configuring subviews
    //
    override func layoutSubviews() {
        
        super.layoutSubviews()
        configureConstraints()
        
    }

    // Method for configuring constraints
    //
    private func configureConstraints() {
        
        itemIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        itemIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        itemIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true

        itemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: itemIcon.trailingAnchor, constant: 20).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        
    }

    // Method for configuring cell
    //
    func configureCell(icon: UIImage?, text: String) {
        
        itemIcon.image = icon
        itemLabel.text = text
        
    }
    
}
