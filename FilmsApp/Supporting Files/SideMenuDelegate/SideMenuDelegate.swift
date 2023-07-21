//
//  SideMenuDelegate.swift
//  FilmsApp
//
//  Created by Raman Kozar on 19/07/2023.
//

import Foundation

// Menu delegate
//
protocol SideMenuDelegate: AnyObject {
    
    func menuButtonTapped()
    func itemSelected(item: ContentViewControllerPresentation)
    func openNavigationBar()
    func closeNavigationBar()
    
}
