//
//  ViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit
import RealmSwift
import SwiftEntryKit

class MainViewController: UIViewController {

    // Setting the parameters
    private var sideMenuViewController: SideMenuViewController!
    private var searchController = UISearchController()
    
    let model = Model()
    let realm = try? Realm()
    let tmdbAPI = TMDB_API()
    
    // Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainMenuButton: UIBarButtonItem!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeSideMenuComponents()
        initializeDataSourceDelegates()
        registerXIBCell()
        
    }
    
    // Function of initialization all the components of side menu
    //
    func initializeSideMenuComponents() {
        
        initializeSideMenu()
        initializeSearchController()
        addChildViewControllers()
        configureGestures()
        
    }
    
    // Registartion XIB cell
    //
    func registerXIBCell() {
        
        let customXIBCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        
        // registering xib-cell
        mainCollectionView.register(customXIBCell, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        model.ratingSort()
        self.mainCollectionView.reloadData()
        
    }
    
    // Initialization of standard properties: dataSource and delegate
    //
    func initializeDataSourceDelegates() {
        
        sideMenuViewController.delegate = self
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
    }
    
    // Method for initialize menu
    //
    func initializeSideMenu() {
        
        let sideMenuItems = [
            SideMenuItem(icon: UIImage(systemName: "house.circle"),
                         name: "Home",
                         viewController: .embed(self)),
            SideMenuItem(icon: UIImage(systemName: "heart.circle"),
                         name: "Favourite",
                         viewController: .push),
            SideMenuItem(icon: UIImage(systemName: "info.circle"),
                         name: "Information",
                         viewController: .pushInfo),
            SideMenuItem(icon: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                         name: "Logout",
                         viewController: .logout)
            
        ]
        
        sideMenuViewController = SideMenuViewController(sideMenuItems: sideMenuItems)
        
    }
    
    // Method for initialize UISearchController
    //
    func initializeSearchController() {
      
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find your movie..."
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
        
        openNavigationBar()
        sideMenuViewController.hide()
        
    }

    @objc private func swipedRight() {
        
        closeNavigationBar()
        sideMenuViewController.show()
        
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        menuButtonTapped()
    }
    
    @IBAction func sortData(_ sender: Any) {
    
        let sortingUp = UIImage(systemName: "arrow.up.circle")
        let sortingDown = UIImage(systemName: "arrow.down.circle")
            
        model.sortAscending = !model.sortAscending
        sortingButton.image = model.sortAscending ? sortingUp : sortingDown
        model.ratingSort()
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
        
    }
    
    @IBAction func showInfoAboutApplication(_ sender: Any) {
        
        SwiftEntryKit.display(entry: SmallPopUpUIView(image: #imageLiteral(resourceName: "tmdb_icon"), name: "You have successfully logged in with your personal key"), using: setupAttributes())
        
    }
    
    func setupAttributes() -> EKAttributes {
        
        var attributes = EKAttributes.bottomFloat
        
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 25)
        
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.2)
            )
        )
        
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        
        return attributes
        
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.arrayHelper?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell,
              
            let item = model.arrayHelper?[indexPath.row] else {
            
            return UICollectionViewCell()
            
        }
        
        cell.data = item
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewControllerID") as? MovieDetailsViewController else {
            return
        }
        
        guard let currID = model.arrayHelper?[indexPath.row].id else {
            return
        }
        
        let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
        
        var isLikedByUser = false
        
        if likedScope?.first != nil {
            isLikedByUser = true
        }
        
        destinationViewController.cameFromFavourite = isLikedByUser
        destinationViewController.receivedIndex = indexPath.row
        destinationViewController.arrayHelper = model.arrayHelper
        destinationViewController.controllerType = .main
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        model.arrayHelper = model.moviesObject
        model.search(searchText)
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.moviesObject
            model.ratingSort()
        }
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        model.arrayHelper = model.moviesObject
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.moviesObject
            model.ratingSort()
        }
        
        model.ratingSort()
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
        
    }
    
}

extension MainViewController: SideMenuDelegate {
    
    // Method for button menu tapping
    //
    func menuButtonTapped() {
        
        DispatchQueue.main.async {
            self.closeNavigationBar()
            self.sideMenuViewController.show()
        }
        
    }

    // Method: event after selecting menu-element
    //
    func itemSelected(item: ContentViewControllerPresentation) {
        
        switch item {
        case .embed(_):
            
            openNavigationBar()
            sideMenuViewController.hide()

        case .push:
            
            guard let favouriteMoviesViewController = storyboard?.instantiateViewController(withIdentifier: "FavouriteMoviesViewControllerID") as? FavouriteMoviesViewController else {
                return
            }
            
            openNavigationBar()
            sideMenuViewController.hide()
            navigationController?.pushViewController(favouriteMoviesViewController, animated: true)
            
        case .pushInfo:
            
            guard let applicationInfoViewController = storyboard?.instantiateViewController(withIdentifier: "ApplicationInfoViewControllerID") as? ApplicationInfoViewController else {
                return
            }
            
            openNavigationBar()
            sideMenuViewController.hide()
            navigationController?.pushViewController(applicationInfoViewController, animated: true)
            
        case .logout:
            
            let refreshAlert = UIAlertController(title: "Logout application", message: "Are you sure that you want to logout?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    CoreDataMethods().deleteAPI_KeyFromCoreData()
                    
                    let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID")
                
                    let navigationViewController = UINavigationController(rootViewController: homeController)
                    navigationViewController.modalTransitionStyle = .crossDissolve
                    navigationViewController.modalPresentationStyle = .fullScreen
                    
                    self.present(navigationViewController, animated: false)
                    
                }
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
    
    }
    
    func openNavigationBar() {
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
    func closeNavigationBar() {
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
    }
    
}


