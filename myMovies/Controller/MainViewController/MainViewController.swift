//
//  ViewController.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    // Setting the parameters
    private var sideMenuViewController: SideMenuViewController!
    private var searchController = UISearchController()
    
    let model = Model()
    let realm = try? Realm()
    
    let tmdbAPI = TMDB_API()
    let imgTMDB_Address = "https://image.tmdb.org/t/p/original"

    
    // Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainMenuButton: UIBarButtonItem!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //print(realm?.configuration.fileURL)
        
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
        
        // reloading data
        DispatchQueue.main.async {
            self.tmdbAPI.dataRequest(requestType: APIRequestParameters.popular)
        }
        
        mainCollectionView.reloadData()
        
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
                         viewController: .pushInfo)
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

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.moviesObject?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell,
              
            let item = model.moviesObject?[indexPath.row] else {
            
            return UICollectionViewCell()
            
        }
        
        cell.data = item
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewControllerID") as? MovieDetailsViewController else {
            return
        }
        
        guard let currID = model.moviesObject?[indexPath.row].id else {
            return
        }
        
        let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
        
        var isLikedByUser = false
        
        if likedScope?.first != nil {
            isLikedByUser = true
        }
        
        destinationViewController.cameFromFavourite = isLikedByUser
        destinationViewController.receivedIndex = indexPath.row
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


