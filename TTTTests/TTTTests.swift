//
//  TTTTests.swift
//  TTTTests
//
//  Created by Kirby Bryant on 10/14/15.
//  Copyright © 2015 AKCB. All rights reserved.
//

import XCTest
@testable import TTT

class TTTTests: XCTestCase {
    
    let p1 = Player.Player1
    let p2 = Player.Player2
    let  e = Player.Empty
    
    var testBoard = Board()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBoardCreation() {
        for i in 0...8 {
            XCTAssertEqual(testBoard.configuration[i], Player.Empty, "Board should be all Empty")
        }
    }
    
    func testCheckWinner() {
        testBoard.configuration = [p1, p2, e,
                                   p1, p2, e,
                                   p1, e, e]
        XCTAssertTrue(TTT().checkForWinner(testBoard, player: .Player1))
        
        testBoard.configuration = [p1,p2,p1,
                                   p1,p2,p1,
                                   p2,p1,p2]
        XCTAssertFalse(TTT().checkForWinner(testBoard, player: .Player1), "Check for winner failed.")
        
        
        
    }
    
    func testIsFinished() {
        testBoard.configuration = [p1,p2,p1,
                                   p1,p1,p1,
                                   p2,p1,p2]
        XCTAssertTrue(TTT().isFinished(testBoard), "This board is finished")
        
        testBoard.configuration = [e,e,e,
                                   p1,p2,p1,
                                   e,e,e]
        XCTAssertFalse(TTT().isFinished(testBoard), "This board is not finished.")
        
        testBoard.configuration = [e,e,e,
                                   e,e,e,
                                   e,e,e]
        XCTAssertFalse(TTT().isFinished(testBoard), "This board is not finished.")
    }
    
    func testMakeMove() {
        var testBoard2 = Board()
        testBoard2.configuration = [p1,p2,p1,p2,p1,p2,p1,p2,p1]
        testBoard.configuration = testBoard2.configuration
        testBoard = TTT().makeMove(0, player: .Player1, board: testBoard)
        XCTAssertEqual(testBoard.configuration, testBoard2.configuration, "A full board should result in the same board.")
        
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        testBoard2.configuration = [p1,e,e,e,e,e,e,e,e]
        testBoard = TTT().makeMove(0, player: .Player1, board: testBoard)
        XCTAssertEqual(testBoard.configuration, testBoard2.configuration, "A simple move")
    }
    
    func testGetScore() {
        let ttt = TTT()
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard), 0, "Nobody wins")
        
        testBoard.configuration = [p1,p2,p1,
                                   p2,p1,p2,
                                   p2,p1,p2]
        XCTAssertEqual(ttt.getScore(testBoard), 0, "This is a draw")
        
        testBoard.configuration = [p1,p1,p1,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard),-1, "This is a loss for the computer")
        
        testBoard.configuration = [p2,p2,p2,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard), 1, "This is a win for the computer")
        
        //Switch players and run same tests
        ttt.human = .Player2
        ttt.computer = .Player1
        
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard), 0, "Nobody wins")
        
        testBoard.configuration = [p1,p2,p1,
                                   p2,p1,p2,
                                   p2,p1,p2]
        XCTAssertEqual(ttt.getScore(testBoard), 0, "This is a draw")
        
        testBoard.configuration = [p1,p1,p1,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard), 1, "This is a win for the computer")
        
        testBoard.configuration = [p2,p2,p2,e,e,e,e,e,e]
        XCTAssertEqual(ttt.getScore(testBoard), -1, "This is a loss for the computer")
    }
    
    func testGetMaxScore() {
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        XCTAssertEqual(TTT().getMaxScore(testBoard), 0, "It assumes it's opponent will play optimally.")
        
        testBoard.configuration = [p2,p2,e,
                                   p1,p2,p1,
                                   p1,p1,e]
        XCTAssertEqual(TTT().getMaxScore(testBoard), 10)
        
        testBoard.configuration = [p1,p1,e,
                                   p1,p1,p2,
                                    e,e,e]
        XCTAssertEqual(TTT().getMaxScore(testBoard), -10)
    }
    
    func testGetMinScore() {
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        XCTAssertEqual(TTT().getMinScore(testBoard), 0)
        
        testBoard.configuration = [p1,p1,e,
                                   p2,e,p2,
                                   p1,e,p1]
        XCTAssertEqual(TTT().getMinScore(testBoard), -10, "The enemy's sure victory means -10 for me.")
        
        testBoard.configuration = [p2,p1,e,
                                   p2,p2,e,
                                    e,p2,p1]
        XCTAssertEqual(TTT().getMinScore(testBoard), 10, "The enemy's loss means +10 for me")
    }
    
    func testGetNextMove() {
        testBoard.configuration = [e,e,e,e,e,e,e,e,e]
        
        XCTAssertEqual(TTT().getNextMove(testBoard), 0, "First move is easy")
        
        //The computer doesn't always take advantage of suboptimal opponents. This would be the next spot for improving the AI.
//        testBoard.configuration = [p2,p1,e,
//                                   p2,e,p1,
//                                   e, e,e]
//        XCTAssertEqual(TTT().getNextMove(testBoard), 6, "Take advantage of suboptimal opponents.")
    }
    
    
    
}

