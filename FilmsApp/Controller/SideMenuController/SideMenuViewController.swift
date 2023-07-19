//
//  SideMenuViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 19/07/2023.
//

import UIKit

final class SideMenuViewController: UIViewController {
   
    private var headerView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        
        return view
        
    }()

    private var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        
        return tableView
        
    }()

    private var sideMenuView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
        
    }()

    private var screenWidth: CGFloat {
        view.frame.size.width
    }

    private var leadingConstraint: NSLayoutConstraint!
    private var shadowColor: UIColor = UIColor(red: 92/255, green: 91/255, blue: 91/255, alpha: 0.5)
    private var sideMenuItems: [SideMenuItem] = []
    
    weak var delegate: SideMenuDelegate?

    convenience init(sideMenuItems: [SideMenuItem]) {
        
        self.init()
        self.sideMenuItems = sideMenuItems
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
        
    }

    // Method for configuring view
    //
    private func configureView() {
       
        view.backgroundColor = .clear
        view.frame.origin.x = -screenWidth

        addSubviews()
        configureTableView()
        configureTapGesture()
        
    }

    // Method for adding subviews
    //
    private func addSubviews() {
        
        view.addSubview(sideMenuView)
        
        sideMenuView.addSubview(headerView)
        sideMenuView.addSubview(tableView)
        
        configureConstraints()
        
    }

    // Method for creating constraints
    //
    private func configureConstraints() {
        
        sideMenuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingConstraint = sideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -view.frame.size.width)
        leadingConstraint.isActive = true
        sideMenuView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.72).isActive = true
        sideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        headerView.topAnchor.constraint(equalTo: sideMenuView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: sideMenuView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: sideMenuView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 130).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: sideMenuView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: sideMenuView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: sideMenuView.bottomAnchor).isActive = true
        
    }

    // Method for configuring table view
    //
    private func configureTableView() {
        
        tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        
    }

    // Method for configuring tap
    //
    private func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGesture)
        
    }

    @objc private func tapped() {
        hide()
    }

    // Method for showing menu
    //
    func show() {
        
        self.view.frame.origin.x = 0
        self.view.backgroundColor = self.shadowColor
        
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }

    // Method for hiding menu
    //
    func hide() {
        
        self.view.backgroundColor = .clear
        
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = -self.screenWidth
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.frame.origin.x = -self.screenWidth
        }
        
    }
    
}

extension SideMenuViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
       
        guard let view = touch.view else {
            return false
        }
        
        if view === headerView || view.isDescendant(of: tableView) {
            return false
        }
        
        return true
    }
    
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuItemCell.identifier, for: indexPath) as? SideMenuItemCell else {
            fatalError("Could not dequeue cell")
        }
        
        let item = sideMenuItems[indexPath.row]
        cell.configureCell(icon: item.icon, text: item.name)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let item = sideMenuItems[indexPath.row]
        delegate?.itemSelected(item: item.viewController)
        
    }
    
}
