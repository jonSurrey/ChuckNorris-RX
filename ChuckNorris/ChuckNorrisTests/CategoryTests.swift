//
//  CategoryTests.swift
//  ChuckNorrisTests
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import XCTest
@testable import ChuckNorris

// MARK: - MockSuccessService
class CategoryMockServiceSuccess:RequestService{
    
    private var mockEmptyList = false
    
    init(mockEmptyList:Bool = false) {
        self.mockEmptyList = mockEmptyList
    }
    
    override func getCategoriesList() {
        let categories = mockEmptyList ? [] : ["Animal", "Carrer", "Celebrity", "Dev"]
        delegate?.onCategoriesReceived(categories)
    }
    
    override func getRandomJoke(for category: String? = nil) {
        let values:[String] = category != nil ? [category!]:[]
        let joke   = Joke(value: "", categories: values)
        delegate?.onJokeReceived(joke)
    }
}

// MARK: - MockFailureService
class CategoryMockServiceFailure:RequestService{
    
    enum MockError: Error {
        case someExpectedError
    }
    
    override func getCategoriesList() {
        delegate?.onFailure(MockError.someExpectedError)
    }
}

class CategoryTests: XCTestCase {
    
    func testSuccessToGetCategories() {
        let viewModel = CategoryViewModel()
        viewModel.setup(CategoryMockServiceSuccess())
        
        XCTAssertTrue(viewModel.categories.value.isEmpty, "Request not executed yet, the list should be empty, but it is not")
        viewModel.requestCategories()
        XCTAssertFalse(viewModel.categories.value.isEmpty, "Request executed, the list should not be empty, but it is")
    }
    
    func testSuccessToGetCategoriesButEmptyResult() {
        let viewModel = CategoryViewModel()
        viewModel.setup(CategoryMockServiceSuccess(mockEmptyList: true))
        
        XCTAssertTrue(viewModel.categories.value.isEmpty, "Request not executed yet, the list should be empty, but it is not")
        viewModel.requestCategories()
        XCTAssertTrue(viewModel.categories.value.isEmpty, "Request executed, the list should be empty, but it is not")
    }
    
    func testFailureToGetCategories() {
        let viewModel = CategoryViewModel()
        viewModel.setup(CategoryMockServiceFailure())
        
        XCTAssertFalse(viewModel.hasError.value, "Request not executed yet, ''hasError'' should be false, but it is not")
        viewModel.requestCategories()
        XCTAssertTrue(viewModel.hasError.value, "Request executed, ''hasError'' should be true, but it is not")
    }
    
    func testSuccessToGetTheDetailOfCategory() {
        let expectedResult = "food"
        let viewModel      = CategoryDetailViewModel()
        viewModel.setup(expectedResult, service: CategoryMockServiceSuccess())
        
        XCTAssertNil(viewModel.joke.value, "Request not executed yet, ''joke'' should be nil, but it is not")
        viewModel.requestJoke()
        XCTAssertEqual(viewModel.joke.value?.category, expectedResult, "Request executed, the category of the joke object should be \(expectedResult), but it is not")
    }
}
