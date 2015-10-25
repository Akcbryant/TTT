//
//  TTTView.swift
//  TTT
//
//  Created by Kirby Bryant on 10/14/15.
//  Copyright © 2015 AKCB. All rights reserved.
//

import UIKit

protocol TTTViewDelegate {
    func gridPressed(position: Int, sender: UIButton)
    func xButtonPressed(sender: UIButton)
    func oButtonPressed(sender: UIButton)
}

class TTTView: UIView {
    
    var infoLabel = UILabel()
    var buttons = [UIButton]()
    var xButton = UIButton()
    var oButton = UIButton()
    
    var delegate: TTTViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addGrid()
        addLabel()
        addBottomButtons()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderMove(position: Int, player: Player) {
        if player == .Player1 {
            buttons[position].setBackgroundImage(UIImage(named: "X.png"), forState: .Normal)
        } else if player == .Player2 {
            buttons[position].setBackgroundImage(UIImage(named: "O.png"), forState: .Normal)
        } else {
            buttons[position].setBackgroundImage(nil, forState: .Normal)
        }
    }
    
    //Convenience Functions
    
    func resetButtons() {
        for button in buttons {
            button.setBackgroundImage(nil, forState: .Normal)
        }
    }
    
    func addGrid() {
        var buttonCoordinates = [CGPoint(x: frame.width * (1/8), y: self.frame.height * (3/12)),
                    CGPoint(x: frame.width * (3/8), y: frame.height * (3/12)),
                    CGPoint(x: frame.width * (5/8), y: frame.height * (3/12)),
                    CGPoint(x: frame.width * (1/8), y: frame.height * (5/12)),
                    CGPoint(x: frame.width * (3/8), y: frame.height * (5/12)),
                    CGPoint(x: frame.width * (5/8), y: frame.height * (5/12)),
                    CGPoint(x: frame.width * (1/8), y: frame.height * (7/12)),
                    CGPoint(x: frame.width * (3/8), y: frame.height * (7/12)),
                    CGPoint(x: frame.width * (5/8), y: frame.height * (7/12))]
        let buttonHeight = frame.height * (1/6)
        let buttonWidth = frame.width * (1/4)
        
        for i in 0...8 {
            let newButton = UIButton(type: .System)
            newButton.frame = CGRect(x: buttonCoordinates[i].x, y: buttonCoordinates[i].y, width: buttonWidth, height: buttonHeight)
            newButton.addTarget(self, action: "gridButtonPressed:", forControlEvents: .TouchUpInside)
            buttons.append(newButton)
            self.addSubview(newButton)
        }
        
        let gridImage = UIImage(named: "grid.png")
        let grid = UIImageView(image: gridImage)
        grid.contentMode = .ScaleToFill
        grid.frame = CGRect(x: buttonCoordinates[0].x, y: buttonCoordinates[0].y, width: buttonWidth * 3, height: buttonHeight * 3)
        self.addSubview(grid)
    }
    

    func addLabel() {
        infoLabel.frame = CGRect(x: frame.width * (1/8), y: frame.height * (1/12), width: frame.width * (3/4), height: frame.height * (3/24))
        infoLabel.textAlignment = .Center
        infoLabel.text = "X goes first! Pick!!!"
        self.addSubview(infoLabel)
    }
    
    func addBottomButtons() {
        let xButton = UIButton(type: .System)
        xButton.frame = CGRect(x: frame.width * (1/8), y: frame.height * (10/12), width: frame.width * (2/8), height: frame.height * (1/8))
        xButton.setBackgroundImage(UIImage(named: "X.png"), forState: .Normal)
        xButton.addTarget(self, action: "xButtonPressed:", forControlEvents: .TouchUpInside)
        addSubview(xButton)
        
        let oButton = UIButton(type: .System)
        oButton.frame = CGRect(x: frame.width * (5/8), y: frame.height * (10/12), width: frame.width * (2/8), height: frame.height * (1/8))
        oButton.setBackgroundImage(UIImage(named: "O.png"), forState: .Normal)
        oButton.addTarget(self, action: "oButtonPressed:", forControlEvents: .TouchUpInside)
        addSubview(oButton)
    }
    
    //Actions
    func gridButtonPressed(sender: UIButton) {
        let position = buttons.indexOf(sender)!
        if let delegate = delegate {
            delegate.gridPressed(position, sender: sender)
        }
    }
    
    func xButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.xButtonPressed(sender)
        }
    }
    
    func oButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.oButtonPressed(sender)
        }
    }
}
