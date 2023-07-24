//
//  TestPreview.swift
//  FilmsApp
//
//  Created by Raman Kozar on 21/07/2023.
//

import Foundation

class TestDetailPreviewModel {
    
    var testPic: String?
    
    init(testPic: String?) {
        self.testPic = testPic
    }
    
}

class TestDetailPreviewMethods {
    
    func returnTestArray() -> [TestDetailPreviewModel] {
        
        return [
            
            TestDetailPreviewModel(testPic: "100_100_test_preview_1"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_2"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_3"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_4"),
            TestDetailPreviewModel(testPic: nil)
            
        ]
        
    }
    
}
