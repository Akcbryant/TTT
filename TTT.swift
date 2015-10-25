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
    
    func isFinished(board: Board) -> Bool {
        for i in board.configuration {
            if i == .Empty {
                return false
            }
        }
        return true
    }
    
    func makeMove(position: Int, player: Player, board: Board) -> Board {
        if isFinished(board) {
            return board
        }
        var newBoard = board
        newBoard.configuration[position] = player
        return newBoard
    }
    
    func getScore(board: Board) -> Int {
        if (checkForWinner(board, player: computer)) {
            return 1
        } else if checkForWinner(board, player: human) {
            return -1
        }
        return 0
    }

    
    //Kicks off the alternating recursion starting with getMinScore
    func getNextMove(board: Board) -> Int {
        // If not an end game situation recursively alternate between get best move and get worst move.
        
        // If the game is already over return the same board.
        if isFinished(board) {
            return 0
        }
        
        
        // Otherwise we need to look at each game state and alternate min max so we simulate an optimal player.
        
        var bestScore = -100
        var bestMove = 0
        for var i = 0; i < board.configuration.count; i++ {
            if board.configuration[i] == .Empty {
                let newBoard = makeMove(i, player: computer, board: board)
                let nextScore = getMinScore(newBoard)
                if nextScore > bestScore {
                    bestScore = nextScore
                    bestMove = i
                }
            }
        }
        
        return bestMove
        
    }
    
    //Given a board this will find the best move for the computer (I am always assuming there is a computer). Should alternate between GetMinScore and getMaxScore recursively.
    func getMaxScore(board: Board) -> Int {
        
        if checkForWinner(board, player: computer) {
            return 10
        } else if checkForWinner(board, player: human) {
            return -10
        } else if isFinished(board) {
            return 0
        }
        
        var bestScore = -100
        
        for var i = 0; i < board.configuration.count; i++ {
            if board.configuration[i] == .Empty {
                let newBoard = makeMove(i, player: computer, board: board)
                let nextScore = getMinScore(newBoard)
                if nextScore > bestScore {
                    bestScore = nextScore
                }
            }
        }
        
        return bestScore
    }
    
    //Given a board this will find the worst score. Used to simulate the human playing.
    func getMinScore(board: Board) -> Int {
        
        if checkForWinner(board, player: computer) {
            return 10
        } else if checkForWinner(board, player: human) {
            return -10
        } else if isFinished(board) {
            return 0
        }
        
        var bestScore = 100
        
        for var i = 0; i < board.configuration.count; i++ {
            if board.configuration[i] == .Empty {
                let newBoard = makeMove(i, player: human, board: board)
                let nextScore = getMaxScore(newBoard)
                if nextScore < bestScore {
                    bestScore = nextScore
                }
            }
        }
        
        return bestScore
    }
}


