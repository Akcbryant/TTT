//
//  TTTViewControllerTests.swift
//  TTT
//
//  Created by Kirby Bryant on 10/27/15.
//  Copyright © 2015 AKCB. All rights reserved.
//

import XCTest
@testable import TTT


class TTTViewControllerTests: XCTestCase {

    let p1 = Player.Player1
    let p2 = Player.Player2
    let  e = Player.Empty
    
    var testBoard = Board()
    let tttVC = TTTViewController()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testStateMachine() {
        
        tttVC.currentState = .Begin
        tttVC.gridPressed(0, sender: UIButton())
        XCTAssertEqual(tttVC.currentState, CurrentState.HumanTurn)
        
        testBoard.configuration = [p1,e,e,e,p2,e,e,e,e]
        XCTAssertEqual(testBoard.configuration, tttVC.currentBoard.configuration)
    
        tttVC.gridPressed(1, sender: UIButton())
        tttVC.gridPressed(3, sender: UIButton())
        XCTAssertEqual(tttVC.currentState, CurrentState.ComputerWin)
        
        tttVC.currentState = .Draw
        tttVC.xButtonPressed(UIButton())
        XCTAssertEqual(tttVC.currentState, CurrentState.HumanTurn)
        
        tttVC.oButtonPressed(UIButton())
        tttVC.gridPressed(0, sender: UIButton())
        XCTAssertEqual(tttVC.currentState, CurrentState.HumanTurn)
        
    }
    
    func testResetBoard() {
        
        tttVC.currentBoard.configuration = [p1,p2,e,e,e,p2,p1,e,e]
        tttVC.resetBoard()
        
        XCTAssertEqual(tttVC.currentBoard.configuration, Board().configuration)
    }

}
