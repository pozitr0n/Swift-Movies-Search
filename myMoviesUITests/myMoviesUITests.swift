//
//  myMoviesUITests.swift
//  myMoviesUITests
//
//  Created by Raman Kozar on 30/08/2023.
//

import XCTest

final class myMoviesUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }

    func testMoviesApplication() throws {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let spiderManAcrossTheSpiderVerseElement = cellsQuery.otherElements.containing(.staticText, identifier:"Spider-Man: Across the Spider-Verse").element
        spiderManAcrossTheSpiderVerseElement.tap()
        
        let loveButton = app.buttons["love"]
        loveButton.tap()
        loveButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.swipeLeft()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        element.swipeRight()
        
        let spiderManAcrossTheSpiderVerseStaticText = app.scrollViews.otherElements.staticTexts["Spider-Man: Across the Spider-Verse"]
        spiderManAcrossTheSpiderVerseStaticText/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        spiderManAcrossTheSpiderVerseStaticText.tap()
        spiderManAcrossTheSpiderVerseStaticText.tap()
        spiderManAcrossTheSpiderVerseStaticText.swipeUp()
        spiderManAcrossTheSpiderVerseStaticText.tap()
        spiderManAcrossTheSpiderVerseStaticText.tap()
        
        let goRightButton = app.buttons["go right"]
        goRightButton.tap()
        
        let element2 = cellsQuery.children(matching: .other).element
        element2.swipeLeft()
        
        let element3 = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element
        element3.swipeLeft()
        element.swipeRight()
        element2.tap()
        element2.swipeLeft()
        element3.swipeLeft()
        element3.swipeLeft()
        element3.swipeLeft()
        element3.swipeLeft()
        app.navigationBars["myMovies.FullPictureView"].buttons["Back"].tap()
        
        let backButton = app.navigationBars["myMovies.MoviePicturesView"].buttons["Back"]
        backButton.tap()
        
        let mymoviesButton = app.navigationBars["myMovies.MovieDetailsView"].buttons["myMovies"]
        mymoviesButton.tap()
        
        let guardiansOfTheGalaxyVol3Element = cellsQuery.otherElements.containing(.staticText, identifier:"Guardians of the Galaxy Vol. 3").element
        guardiansOfTheGalaxyVol3Element.tap()
        
        let element4 = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element
        element4.swipeLeft()
        element.swipeRight()
        element3.swipeRight()
        goRightButton.tap()
        backButton.tap()
        mymoviesButton.tap()
        
        let mymoviesNavigationBar = app.navigationBars["myMovies"]
        let mainMenuButton = mymoviesNavigationBar.buttons["Main menu"]
        mainMenuButton.tap()
        
        let tablesQuery = app.tables
        let favouriteStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Favourite"]/*[[".cells.staticTexts[\"Favourite\"]",".staticTexts[\"Favourite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        favouriteStaticText.tap()
        app.navigationBars["Favourite Movies"].buttons["myMovies"].tap()
        spiderManAcrossTheSpiderVerseElement.tap()
        loveButton.tap()
        mymoviesButton.tap()
        guardiansOfTheGalaxyVol3Element.tap()
        loveButton.tap()
        mymoviesButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Elemental").element.tap()
        element4.swipeLeft()
        loveButton.tap()
        mymoviesButton.tap()
        mainMenuButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Information"]/*[[".cells.staticTexts[\"Information\"]",".staticTexts[\"Information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["myMovies.ApplicationInfoView"].buttons["myMovies"].tap()
        mainMenuButton.tap()
        favouriteStaticText.tap()
        guardiansOfTheGalaxyVol3Element.tap()
        loveButton.tap()
        mainMenuButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.image, identifier:"love")/*[[".cells.containing(.staticText, identifier:\"Favourite\")",".cells.containing(.image, identifier:\"love\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).tap()
        spiderManAcrossTheSpiderVerseElement.tap()
        element4.swipeLeft()
        element3.swipeRight()
        loveButton.tap()
        
        let sortingButton = mymoviesNavigationBar.buttons["Sorting"]
        sortingButton.tap()
        sortingButton.tap()
                        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
