import Foundation

enum Player {
    case Player1
    case Player2
    case Empty
}

struct Board {
    var configuration = [Player]()
    
    init() {
        configuration = [Player](count: 9, repeatedValue: .Empty)
    }
}

class TTT: NSObject {
    var human = Player.Player1
    var computer = Player.Player2
    
    var currentBoard = Board()
    
    /**
    Checks all possible ways that a player could win.
    
    - parameter board: Board to check.
    - parameter player: Player to check for victory.

    - returns: true if the player won or false if the player did not win or if there is a draw.
    */
    func checkForWinner(board: Board, player: Player) -> Bool {
        let config = board.configuration
        
        //Crude but clear...
        if ((config[0] == player && config[1] == player && config[2] == player) ||
            (config[0] == player && config[3] == player && config[6] == player) ||
            (config[0] == player && config[4] == player && config[8] == player) ||
            (config[3] == player && config[4] == player && config[5] == player) ||
            (config[6] == player && config[7] == player && config[8] == player) ||
            (config[1] == player && config[4] == player && config[7] == player) ||
            (config[2] == player && config[5] == player && config[8] == player) ||
            (config[6] == player && config[4] == player && config[2] == player))
        {
            return true
        }
        return false
    }
    
    /**
     Convenience function to test if a game is finished.
     
     - parameter board: Board to test.
     
     - returns: true if the game is over and false if there is still space left.
    */
    func isFinished(board: Board) -> Bool {
        for i in board.configuration {
            if i == .Empty {
                return false
            }
        }
        return true
    }
    
    /**
     Create a new board with the move included.
     
     - parameter position: Place at which to move.
     - parameter player:   Player for which to move.
     - parameter board:    Board upon which move should be made.
     
     - returns: New board with the move applied or the same board if the move cannot be made.
    */
    func makeMove(position: Int, player: Player, board: Board) -> Board {
        if isFinished(board) {
            return board
        }
        var newBoard = board
        newBoard.configuration[position] = player
        return newBoard
    }
    
    /**
     Get the score for a board.
     
     - parameter board: Board to score
     
     - returns: 1 for computer win, -1 for human win, 0 for draw or not finished.
    */
    func getScore(board: Board) -> Int {
        if (checkForWinner(board, player: computer)) {
            return 1
        } else if checkForWinner(board, player: human) {
            return -1
        }
        return 0
    }
    
    /** 
     Loops through each available move for the current player and makes available the index of that move as well as the score for that move.
     
     - parameter board: The current board to loop through.
     - parameter currentPlayer: The player who will be used to loop through next possible moves.
     - parameter function: A function that takes the current index of the move being made and the corresponding score of this move.
    */
    func boardScoreLoop(board: Board, currentPlayer: Player, function: (index: Int, nextScore: Int) -> Void) {
        for i in 0..<board.configuration.count {
            if board.configuration[i] == .Empty {
                let newBoard = makeMove(i, player: currentPlayer, board: board)
                let nextScore = getNextScore(newBoard, currentPlayer: currentPlayer)
                function(index: i, nextScore: nextScore)
            }
        }
    }
    
    /**
     Finds the next move for the computer player.
     
     - parameter board: Board to find next move.
     
     - returns: position of next move
    */
    func getNextMove(board: Board) -> Int {

        if isFinished(board) {
            return 0
        }
        
        var bestScore = -100
        var bestMove = 0
        
        boardScoreLoop(board, currentPlayer: computer) { (i, nextScore) -> Void in
            if nextScore > bestScore {
                bestScore = nextScore
                bestMove = i
            }
        }
        
        return bestMove
        
    }
    
    /**
        Finds the best or worst score for the computer player based on whose turn it is by recursively trying all possible moves.
     
        - parameter board:  Current board state.
        - parameter player: Player whose turn it is.
     
        - returns: Score of the next move that should be considered.
    */
    func getNextScore(board: Board, currentPlayer: Player) -> Int {
        if checkForWinner(board, player: computer) {
            return 10
        } else if checkForWinner(board, player: human) {
            return -10
        } else if isFinished(board) {
            return 0
        }
        
        let nextPlayer = otherPlayer(currentPlayer)
        var bestScore = setBestScore(currentPlayer)
    
        boardScoreLoop(board, currentPlayer: nextPlayer) { (i, nextScore) -> Void in
            if nextPlayer == self.computer {
                if nextScore > bestScore {
                    bestScore = nextScore
                }
            } else {
                if nextScore < bestScore {
                    bestScore = nextScore
                }
            }
        }
        
        return bestScore
    }
    
    /**
        Convenience function for getNextScore that sets the bestScore for the current Player
     
        - parameter currentPlayer: Player whose turn it is.
     
        - returns: current value that bestScore should have
     */
    func setBestScore(currentPlayer: Player) -> Int {
        if currentPlayer == computer {
            return 100
        } else if currentPlayer == human {
            return -100
        }
        return 0
    }

    
    /**
     Convenience function to quickly grab the opposite player.
     
     - parameter currentPlayer: Player that is currently moving.
     
     - returns: The opposite player.
     */
    func otherPlayer(currentPlayer: Player) -> Player {
        if currentPlayer == .Player1
        {
            return .Player2
        } else if currentPlayer == .Player2 {
            return .Player1
        }
        return .Empty
    }

}


