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
        
        XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Spider-Man: Across the Spider-Verse").element.tap()
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element/*@START_MENU_TOKEN@*/.press(forDuration: 1.4);/*[[".tap()",".press(forDuration: 1.4);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let moviesButton = app.navigationBars["myMovies.MovieDetailsView"].buttons["Movies"]
        moviesButton.tap()
        
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Fast X").element.tap()
        moviesButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Heart of Stone").element.tap()
    
        app.windows.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.swipeLeft()
        app.buttons["go right"].tap()
        app.navigationBars["myMovies.MoviePicturesView"].buttons["Back"].tap()
        app.navigationBars["myMovies.MovieDetailsView"].buttons["Movies"].tap()
        
        let mainMenuButton = app.navigationBars["Movies"].buttons["Main menu"]
        mainMenuButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["App Information"]/*[[".cells.staticTexts[\"App Information\"]",".staticTexts[\"App Information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["myMovies.ApplicationInfoView"].buttons["Movies"].tap()
        mainMenuButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Home"]/*[[".cells.staticTexts[\"Home\"]",".staticTexts[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let app2 = app
        app2.navigationBars["Movies"]/*@START_MENU_TOKEN@*/.staticTexts["Popular movies ▽ "]/*[[".staticTexts[\"Movies\"].staticTexts[\"Popular movies ▽ \"]",".staticTexts[\"Popular movies ▽ \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.tables.staticTexts["Top Rated"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Top Rated\"]",".staticTexts[\"Top Rated\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"The Godfather").element.tap()
        app.buttons["love"].tap()
        
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
