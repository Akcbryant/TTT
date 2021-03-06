# TTT
Tic-Tac-Toe

A simple game of Tic-Tac-Toe written with Swift. 

The following three files were created with an MVC architecture in mind. The following three files represent MVC respectively.

`TTT.Swift` - Includes the AI of the game and the Board logic.

`TTTView.Swift` - Takes care of creating and laying out the buttons and delegates the button presses to a TTTViewDelegate.

`TTTViewController.Swift` - As a TTTViewDelegate, updates the TTT model and coordinates between the other two classes. This includes a state machine that keeps track of the current state of the game board and makes decisions about updating the model and the view accordingly.

# Build Steps

`git clone https://github.com/Akcbryant/TTT.git`

Use TTT.xcodeproj to launch the project and run the application in the simulator.  

Built with Xcode 7.1 and requires Swift 2.x

NOTE: Xcode 7.0 and higher has Swift 2.x

# Testing

One can find tests in the folder TTTTests and they are ready to run using the Xcode test feature.

Testing covers TTT.swift and TTTViewController.swift

