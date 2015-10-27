import Foundation
import UIKit

enum CurrentState: String {
    case Begin = "Pick your piece."
    case Draw = "That's a DRAW. Try again!"
    case ComputerTurn = "I'm Moving!"
    case HumanTurn = "It's your turn!"
    case ComputerWin = "Computers rule! Pick again!"
}

public class TTTViewController: UIViewController, TTTViewDelegate {
    

    var currentBoard = Board()
    var tttEngine = TTT()
    var tttBoardView: TTTView?
    
    var currentState = CurrentState.Begin {
        didSet {
            tttBoardView?.infoLabel.text = currentState.rawValue
            checkCurrentState()
        }
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
    
        tttBoardView = TTTView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(tttBoardView!)
        tttBoardView!.delegate = self
    }
    
    /**
     Checks validity of move and processes it if it is valid.   
    
     - parameter position: Position that was tapped.
    */
    func gridPressed(position: Int, sender: UIButton) {
        if currentBoard.configuration[position] == Player.Empty {
            processMove(position, player: tttEngine.human, board: currentBoard)
        }
    }
    
    /**
     Serves to read current state of the board and get the appropriate next step/move.
     */
    func checkCurrentState() {
        if currentState == .ComputerTurn {
            let nextMove = tttEngine.getNextMove(currentBoard)
            processMove(nextMove, player: tttEngine.computer, board: currentBoard)
        }
    }
    
    /**
     Takes a possible move and takes the appropriate action based on the current state of the board.
     
     - parameter position: The place one wants to move.
     - parameter player: The player that wishes to move.
     - parameter board: The board upon which one wants to move.
    */
    func processMove(position: Int, player: Player, board: Board) {
        if tttEngine.isFinished(board) {
            currentState = .Draw
        } else if tttEngine.checkForWinner(board, player: tttEngine.computer) {
            currentState = .ComputerWin
        } else if player == tttEngine.human {
            currentBoard = tttEngine.makeMove(position, player: player, board: board)
            tttBoardView?.renderMove(position, player: player)
            currentState = .ComputerTurn
        } else if player == tttEngine.computer {
            currentBoard = tttEngine.makeMove(position, player: player, board: board)
            tttBoardView?.renderMove(position, player: player)
            if tttEngine.checkForWinner(currentBoard, player: tttEngine.computer) {
                currentState = .ComputerWin
            } else {
                currentState = .HumanTurn
            }
        }
    }
    
    func xButtonPressed(sender: UIButton) {
        resetBoard()
        tttEngine.human = .Player1
        tttEngine.computer = .Player2
        currentState = .HumanTurn
    }
    
    func oButtonPressed(sender: UIButton) {
        resetBoard()
        tttEngine.human = .Player2
        tttEngine.computer = .Player1
        currentState = .ComputerTurn
    }

    func resetBoard() {
        currentBoard = Board()
        tttBoardView?.resetButtons()
        currentState = .Begin
    }
    
}
