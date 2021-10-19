//
//  TestingAutoCompleteFunction.swift
//  ListedTests
//
//  Created by Mbuso on 2021/10/19.
//
@testable import Listed
import XCTest

class TestingAutoCompleteFunction: XCTestCase {

    var detailView: DetailView!
    
    override func setUp() {
        super.setUp()
        detailView = DetailView()
    }
    
    override func tearDown() {
        super.tearDown()
        detailView = nil
    }
    
    func test_is_autoCompletingTask() throws{
        XCTAssertNoThrow(
            try detailView.autoCompleteMainTask(0)
        )
    }
    
    func test_autoCompletingTas_is_crashing() throws{
        XCTAssertThrowsError(
            try detailView.autoCompleteMainTask(nil)
        )
    }

}
