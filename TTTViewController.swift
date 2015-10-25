import Foundation
import UIKit

public class TTTViewController: UIViewController, TTTViewDelegate {
    

    var currentBoard = Board()
    var tttEngine = TTT()
    
    var tttBoardView: TTTView?
    
    public override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
    
        
        tttBoardView = TTTView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(tttBoardView!)
        tttBoardView!.delegate = self
    }
    
    func gridPressed(position: Int, sender: UIButton) {
        if tttEngine.human == .Empty {
            tttBoardView!.infoLabel.text = "Pick your piece!"
        } else if currentBoard.configuration[position] == Player.Empty{
            tttBoardView?.infoLabel.text = "Good move!!!"
            currentBoard = tttEngine.makeMove(position, player: tttEngine.human, board: currentBoard)
            tttBoardView?.renderMove(position, player: tttEngine.human)
        }
        
        
        if tttEngine.checkForWinner(currentBoard, player: tttEngine.computer) {
            tttBoardView?.infoLabel.text = "Computers rule! Pick again!"
        } else if tttEngine.isFinished(currentBoard) {
            tttBoardView?.infoLabel.text = "That's a DRAW. Try again!"
        } else {
            let nextMove = tttEngine.getNextMove(currentBoard)
            tttBoardView?.renderMove(nextMove, player: tttEngine.computer)
            currentBoard = tttEngine.makeMove(nextMove, player: tttEngine.computer, board: currentBoard)
            if tttEngine.checkForWinner(currentBoard, player: tttEngine.computer) {
                tttBoardView?.infoLabel.text = "Computers rule! Try again!"
                tttEngine.human = .Empty
            }
        }
    }
    
    
    func xButtonPressed(sender: UIButton) {
        resetBoard()
        tttEngine.human = .Player1
        tttEngine.computer = .Player2
    }
    
    func oButtonPressed(sender: UIButton) {
        resetBoard()
        tttEngine.human = .Player2
        tttEngine.computer = .Player1
        
        //Computer starts.
        let nextMove = tttEngine.getNextMove(currentBoard)
        currentBoard = tttEngine.makeMove(nextMove, player: tttEngine.computer, board: currentBoard)
        tttBoardView?.renderMove(nextMove, player: tttEngine.computer)
    }

    func resetBoard() {
        currentBoard = Board()
        tttBoardView?.resetButtons()
    }
    
}
