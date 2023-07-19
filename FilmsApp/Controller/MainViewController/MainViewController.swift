//
//  ViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit

class MainViewController: UIViewController {

    // Test
    var testArray: [Item] = Model().testArray
    
    // Parameters
    private var sideMenuViewController: SideMenuViewController!
    
    // Outlets
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeSideMenu()
        addChildViewControllers()
        configureGestures()
        initializeDataSourceDelegates()
        registerXIBCell()
        
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        
        mainCollectionView.register(customXIBCell, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        mainCollectionView.reloadData()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
        
        sideMenuViewController.delegate = self
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        moviesSearchBar.delegate = self
        
    }
    
    // Method for initialize menu
    //
    func initializeSideMenu() {
        
        guard let favouriteMoviesViewController = storyboard?.instantiateViewController(withIdentifier: "FavouriteMoviesViewControllerID") as? FavouriteMoviesViewController else {
            return
        }
        
        let sideMenuItems = [
            SideMenuItem(icon: UIImage(systemName: "house.circle"),
                         name: "Home",
                         viewController: .embed(self)),
            SideMenuItem(icon: UIImage(systemName: "heart.circle"),
                         name: "Favourite",
                         viewController: .push(favouriteMoviesViewController))
        ]
        
        sideMenuViewController = SideMenuViewController(sideMenuItems: sideMenuItems)
        
    }
    
    // Method for adding child elements on the view controller
    //
    private func addChildViewControllers() {
        
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
        
    }
    
    // Method for configuring swipes
    //
    private func configureGestures() {
       
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeLeftGesture)

        let rightSwipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipedRight))
        rightSwipeGesture.cancelsTouchesInView = false
        rightSwipeGesture.edges = .left
        view.addGestureRecognizer(rightSwipeGesture)
        
    }
    
    @objc private func swipedLeft() {
        sideMenuViewController.hide()
    }

    @objc private func swipedRight() {
        sideMenuViewController.show()
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        menuButtonTapped()
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.fillDataIntoCell(testArray[indexPath.row].testPic,
                              testArray[indexPath.row].testTitle,
                              testArray[indexPath.row].testYear,
                              testArray[indexPath.row].testRating)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewControllerID") as? MovieDetailsViewController else {
            return
        }
        
        destinationViewController.receivedIndex = indexPath.row
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}

extension MainViewController: SideMenuDelegate {
    
    // Method for button menu tapping
    //
    func menuButtonTapped() {
        
        mainMenuButton.tintColor = .darkGray
        sideMenuViewController.show()
        
    }

    // Method: event after selecting menu-element
    //
    func itemSelected(item: ContentViewControllerPresentation) {
        
        switch item {
        case .embed(_):
            
            sideMenuViewController.hide()

        case let .push(viewController):
            
            sideMenuViewController.hide()
            navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
}

