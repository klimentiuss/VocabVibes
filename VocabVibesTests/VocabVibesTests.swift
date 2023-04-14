//
//  VocabVibesTests.swift
//  VocabVibesTests
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import XCTest

final class VocabVibesTests: XCTestCase {
    
    var viewModel: ListOfGroupsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ListOfGroupsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCreateNewGroup() {
        let groupName = "Test Group"
        let initialCount = viewModel.wordList.count
        
        viewModel.groupName = groupName
        viewModel.createNewGroup()
        
        let newCount = viewModel.wordList.count
        
        XCTAssertEqual(newCount, initialCount + 1)
        
        let lastGroup = viewModel.wordList.last
        XCTAssertNotNil(lastGroup)
        XCTAssertEqual(lastGroup?.nameOfGroup, groupName)
        XCTAssertTrue(lastGroup?.words.isEmpty ?? false)
    }
    
    
}
