//
//  myMoviesUnitTests.swift
//  myMoviesUnitTests
//
//  Created by Raman Kozar on 30/08/2023.
//

import XCTest
@testable import myMovies

final class myMoviesUnitTests: XCTestCase {

    // initial data
    var mockMovie: MovieMock? = nil
    
    let testId: Int = 615656
    let testMoviePicture: String = "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg"
    let testMovieTitle: String = "Meg 2: The Trench"
    let testAbout: String = "An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival."
    let testMovieYear: Int = 2023
    let testIsLikedByUser: Bool = false
    
    // data for comparing
    let mockId: Int = 976573
    let mockMoviePicture: String = "/4Y1WNkd88JXmGfhtWR7dmDAo1T2.jpg"
    let mockMovieTitle: String = "Melemental"
    let mockAbout: String = "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common."
    let mockMovieYear: Int = 2022
    let mockIsLikedByUser: Bool = true
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // test user
        mockMovie = MovieMock()
        mockMovie?.id = testId
        mockMovie?.moviePicture = testMoviePicture
        mockMovie?.movieTitle = testMovieTitle
        mockMovie?.about = testAbout
        mockMovie?.movieYear = testMovieYear
        mockMovie?.isLikedByUser = testIsLikedByUser
        
    }

    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockMovie = nil
        
    }

    func testchangeId() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeId(mockId)
        
        XCTAssertTrue(mockMovie.changeIdCounter > 0)
        XCTAssertTrue(mockMovie.changeIdCalled)
        XCTAssertTrue(mockMovie.id == mockId)
        
    }
    
    func testchangeMoviePicture() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeMoviePicture(mockMoviePicture)
        
        XCTAssertTrue(mockMovie.changeMoviePictureCounter > 0)
        XCTAssertTrue(mockMovie.changeMoviePictureCalled)
        XCTAssertTrue(mockMovie.moviePicture == mockMoviePicture)
        
    }
    
    func testchangeMovieTitle() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeMovieTitle(mockMovieTitle)
        
        XCTAssertTrue(mockMovie.changeMovieTitleCounter > 0)
        XCTAssertTrue(mockMovie.changeMovieTitleCalled)
        XCTAssertTrue(mockMovie.movieTitle == mockMovieTitle)
        
    }
    
    func testchangeAbout() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeAbout(mockAbout)
        
        XCTAssertTrue(mockMovie.changeAboutCounter > 0)
        XCTAssertTrue(mockMovie.changeAboutCalled)
        XCTAssertTrue(mockMovie.about == mockAbout)
        
    }
    
    func testchangeMovieYear() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeMovieYear(mockMovieYear)
        
        XCTAssertTrue(mockMovie.changeMovieYearCounter > 0)
        XCTAssertTrue(mockMovie.changeMovieYearCalled)
        XCTAssertTrue(mockMovie.movieYear == mockMovieYear)
        
    }
    
    func testchangeIsLikedByUser() throws {
        
        guard let mockMovie = mockMovie else {
            return
        }
        
        mockMovie.changeIsLikedByUser(mockIsLikedByUser)
        
        XCTAssertTrue(mockMovie.changeIsLikedByUserConuter > 0)
        XCTAssertTrue(mockMovie.changeIsLikedByUserCalled)
        XCTAssertTrue(mockMovie.isLikedByUser == mockIsLikedByUser)
        
    }
    
    func testPerformanceExample() throws {
        
        measure(
            metrics: [
                
                // XCTClockMetric() - shows the time for which the test was completed
                // XCTCPUMetric() - shows interaction with the CPU (time, cycles, number of instructions)
                // XCTStorageMetric() - measuring the amount of data that will potentially be written to the storage when a specified block of code is executed
                // XCTMemoryMetric() - indications of RAM usage
                
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
                
            ]
        ) {
        }
    }

}
