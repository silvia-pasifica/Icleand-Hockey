//
//  WinningScene.swift
//  Iceland Hockey
//
//  Created by Silvia Pasica on 25/05/23.
//

import SpriteKit

class WinningScene: SKScene {
    let winnerLabel = SKLabelNode()
    let winnerLabel1 = SKLabelNode()
    let playAgainButton = SKLabelNode()
    var winnerName = "player"
    
    private var image1: SKSpriteNode!
    private var image2: SKSpriteNode!
    
    override func didMove(to view: SKView) {
//        self.backgroundColor = UIColor(red: 90/255, green: 99/255, blue: 136/255, alpha: 1.0)
        self.backgroundColor = .white
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        background.size = CGSize(width: 1412, height: 1000)
        background.alpha = 0.28
        addChild(background)
        
        image1 = SKSpriteNode(imageNamed: "15")
        image1.size = CGSize(width: 300, height: 300)
        image1.position = CGPoint(x: frame.midX - 300, y: frame.midY)
        addChild(image1)
        
        image2 = SKSpriteNode(imageNamed: "16")
        image2.size = CGSize(width: 350, height: 350)
        image2.position = CGPoint(x: frame.midX + 310, y: frame.midY)
        addChild(image2)
        
        winnerLabel1.text = "Congratulations! "
        winnerLabel1.fontSize = 40
        winnerLabel1.fontName = "Helvetica-bold"
        winnerLabel1.fontColor = .white
        winnerLabel1.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(winnerLabel1)
        
        winnerLabel.text = "\(winnerName) Won!"
        winnerLabel.fontSize = 40
        winnerLabel.fontName = "Helvetica-bold"
        winnerLabel.fontColor = .white
        winnerLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        addChild(winnerLabel)
        
        let backgroundNodeWinning = SKShapeNode(rect: CGRect(x: -winnerLabel.frame.width / 2 - 75, y: -winnerLabel.frame.height / 2 - 200, width: 400, height: 300), cornerRadius: 20.0)
        backgroundNodeWinning.fillColor = UIColor(red: 90/255, green: 99/255, blue: 136/255, alpha: 1.0)
        backgroundNodeWinning.strokeColor = UIColor.clear
        backgroundNodeWinning.zPosition = -1
        winnerLabel1.addChild(backgroundNodeWinning)
        
        playAgainButton.text = "Play Again!"
        playAgainButton.fontName = "Helvetica-semiBold"
        playAgainButton.fontSize = 30
        playAgainButton.fontColor = UIColor(red: 90/255, green: 99/255, blue: 136/255, alpha: 1.0)
        playAgainButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        
//        let backgroundNode = SKShapeNode(rect: CGRect(x: frame.midX - 950, y: frame.midY , width: playAgainButton.frame.width + 40, height: playAgainButton.frame.height + 20))
        let backgroundNode = SKShapeNode(rect: CGRect(x: -playAgainButton.frame.width / 2 - 25, y: -playAgainButton.frame.height / 2 - 5, width: playAgainButton.frame.width + 50, height: playAgainButton.frame.height + 30), cornerRadius: 15.0)
        backgroundNode.fillColor = .white
        backgroundNode.strokeColor = UIColor.clear
        backgroundNode.zPosition = -1
        playAgainButton.addChild(backgroundNode)
        
        
        addChild(playAgainButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playAgainButton.contains(location) {
                // Play Again button tapped, transition to the game scene
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = scaleMode
                view?.presentScene(gameScene, transition: .fade(withDuration: 0.5))
            }
        }
    }
}

