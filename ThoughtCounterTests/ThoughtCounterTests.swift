//
//  ThoughtCounterTests.swift
//  ThoughtCounterTests
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import XCTest
@testable import ThoughtCounter

class ThoughtCounterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThoughtViewModel() {
        let thought = Thought.init(title: "test")
        let thoughtViewModel = ThoughtViewModel.init(thought: thought)
        XCTAssertEqual(thought.title, thoughtViewModel.title)
    }
}
