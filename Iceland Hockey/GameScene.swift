import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var playerPaddle: SKSpriteNode!
    private var opponentPaddle: SKSpriteNode!
    private var puck: SKSpriteNode!
    private var obstacle1: SKSpriteNode!
    private var obstacle2: SKSpriteNode!
    private var obstacle3: SKSpriteNode!
    private var paddleLimitRect: CGRect!
    private var playerTouch: UITouch?
    private var opponentTouch: UITouch?
    private var playerScoreLabel: SKLabelNode!
    private var opponentScoreLabel: SKLabelNode!
    private var playerScore = 0
    private var opponentScore = 0//    private let goalCategory: UInt32 = 0x1 << 1
    private var flag = -1
    
    
    // Category bit masks for physics bodies
    private let puckCategory: UInt32 = 0x1 << 0
    private let goalCategory1: UInt32 = 0x1 << 1
    private let goalCategory2: UInt32 = 0x1 << 2
    private let wallCategory: UInt32 = 0x1 << 3
    private let paddleCategory: UInt32 = 0x1 << 4
    private let obstacleCategory: UInt32 = 0x1 << 5
    
    func createPaddle() {
        // Add player paddle
        let paddleMargin: CGFloat = frame.width * 0.05
        let paddleLimitSize = CGSize(width: frame.width * 0.5 - paddleMargin * 2, height: frame.height - paddleMargin * 2)
        let paddleLimitOrigin = CGPoint(x: paddleMargin, y: paddleMargin)
        paddleLimitRect = CGRect(origin: paddleLimitOrigin, size: paddleLimitSize)
        
        playerPaddle = SKSpriteNode(imageNamed: "paddle")
        playerPaddle.size = CGSize(width: 100, height: 100)
        playerPaddle.position = CGPoint(x: frame.minX + playerPaddle.size.width / 2 + paddleMargin, y: frame.midY)
        addChild(playerPaddle)

        // Add opponent paddle
        opponentPaddle = SKSpriteNode(imageNamed: "paddle")
        opponentPaddle.size = CGSize(width: 100, height: 100)
        opponentPaddle.position = CGPoint(x: frame.maxX - opponentPaddle.size.width / 2 - paddleMargin, y: frame.midY)
        addChild(opponentPaddle)
        
        // Configure physics bodies
        playerPaddle.physicsBody = SKPhysicsBody(circleOfRadius:playerPaddle.size.width/2)
        playerPaddle.physicsBody?.isDynamic = false
        playerPaddle.physicsBody?.mass = 0.1
        
        opponentPaddle.physicsBody = SKPhysicsBody(circleOfRadius:opponentPaddle.size.width/2)
        opponentPaddle.physicsBody?.isDynamic = false
        opponentPaddle.physicsBody?.mass = 0.1
        
        playerPaddle.physicsBody?.categoryBitMask = paddleCategory
        opponentPaddle.physicsBody?.categoryBitMask = paddleCategory
        playerPaddle.physicsBody?.collisionBitMask = wallCategory | puckCategory | obstacleCategory
        opponentPaddle.physicsBody?.collisionBitMask = wallCategory | puckCategory | obstacleCategory
//        playerPaddle.physicsBody?.contactTestBitMask =  obstacleCategory
//        opponentPaddle.physicsBody?.contactTestBitMask = obstacleCategory

    }
    
    func createGoalArea(at position: CGPoint, area: Int) -> SKSpriteNode {
        let goalArea = SKSpriteNode(color: UIColor(red: 0.23, green: 0.26, blue: 0.38, alpha: 1.0), size: CGSize(width: 20, height: (frame.height/2) - 115))
        goalArea.position = position
        goalArea.zPosition = -1
        
        let goalBody = SKPhysicsBody(rectangleOf: goalArea.size)
        goalBody.isDynamic = false
        if area == 1{
            goalBody.categoryBitMask = goalCategory1
        }else if area == 2 {
            goalBody.categoryBitMask = goalCategory2
        }
        
        goalBody.contactTestBitMask = puckCategory
        goalArea.physicsBody = goalBody
        
        addChild(goalArea)
        
        return goalArea
    }
    
    func createScoreLabels() {
        playerScoreLabel = SKLabelNode(text: "Player 1: 0")
        playerScoreLabel.position = CGPoint(x: frame.midX - 100, y: frame.maxY - 50)
        playerScoreLabel.fontColor = UIColor(red: 0.23, green: 0.26, blue: 0.38, alpha: 0.75)
//        playerScoreLabel.fontName = "Arial"
        playerScoreLabel.fontName = "Helvetica-semiBold"
        playerScoreLabel.fontSize = 32
        addChild(playerScoreLabel)
        
        opponentScoreLabel = SKLabelNode(text: "Player 2: 0")
        opponentScoreLabel.position = CGPoint(x: frame.midX + 100, y: frame.maxY - 50)
        opponentScoreLabel.fontColor = UIColor(red: 0.23, green: 0.26, blue: 0.38, alpha: 0.75)
        opponentScoreLabel.fontName = "Helvetica-semiBold"
        opponentScoreLabel.fontSize = 32
        addChild(opponentScoreLabel)
    }
    
    func createEdges() {
        let bumperDepth = CGFloat(5.0)
        
        let topEdge = SKSpriteNode(color: .clear, size: CGSize(width: size.height + 300, height: bumperDepth))
        topEdge.position = CGPoint(x: frame.width/2, y: size.height - bumperDepth/2)
        
        // Setup physics for this edge
        topEdge.physicsBody = SKPhysicsBody(rectangleOf: topEdge.size)
        topEdge.physicsBody!.isDynamic = false
        addChild(topEdge)
        
        // Copy the top edge and position it as the bottom edge
        let bottomEdge = topEdge.copy() as! SKSpriteNode
        bottomEdge.position = CGPoint(x: frame.width/2, y: bumperDepth/2)
        addChild(bottomEdge)
        
        // Calculate some values for the end bumpers (four needed to allow for goals)
        let endBumperWidth = (size.height / 2) - 150
        let endBumperSize = CGSize(width: bumperDepth, height: endBumperWidth)
        let endBumperPhysics = SKPhysicsBody(rectangleOf: endBumperSize)
        endBumperPhysics.isDynamic = false
        
        // Create a left edge
        let leftEdge = SKSpriteNode(color: .clear, size: endBumperSize)
        leftEdge.position = CGPoint(x: bumperDepth/2, y: endBumperWidth/2)
        leftEdge.physicsBody = endBumperPhysics
        addChild(leftEdge)
        
        // Copy edge to other three locations
        let rightEdge = leftEdge.copy() as! SKSpriteNode
        rightEdge.position = CGPoint(x: size.width - bumperDepth/2, y: endBumperWidth/2)
        addChild(rightEdge)
        
        let topLeftEdge = leftEdge.copy() as! SKSpriteNode
        topLeftEdge.position = CGPoint(x: bumperDepth/2, y: size.height - endBumperWidth/2)
        addChild(topLeftEdge)
        
        let topRightEdge = rightEdge.copy() as! SKSpriteNode
        topRightEdge.position = CGPoint(x: size.width - bumperDepth/2, y: size.height - endBumperWidth/2)
        addChild(topRightEdge)
        
        topEdge.physicsBody?.categoryBitMask = wallCategory
        bottomEdge.physicsBody?.categoryBitMask = wallCategory
        leftEdge.physicsBody?.categoryBitMask = wallCategory
        rightEdge.physicsBody?.categoryBitMask = wallCategory
        topLeftEdge.physicsBody?.categoryBitMask = wallCategory
        topRightEdge.physicsBody?.categoryBitMask = wallCategory
        topEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory
        bottomEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory
        leftEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory
        rightEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory
        topLeftEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory
        topRightEdge.physicsBody?.collisionBitMask = puckCategory | paddleCategory

    }
    
    func createPuck() {
        if puck == nil {
            // Add puck
            puck = SKSpriteNode(imageNamed: "puck")
            puck.size = CGSize(width: 50, height: 50)
            

            puck.physicsBody = SKPhysicsBody(circleOfRadius: puck.size.width/2)
            puck.physicsBody?.isDynamic = true
            puck.physicsBody?.friction = 0.0
            puck.physicsBody?.restitution = 0.7
            puck.physicsBody?.linearDamping = 0.4
            //            puck.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            puck.physicsBody?.angularDamping = 0.0
            puck.physicsBody?.allowsRotation = false
            puck.physicsBody?.categoryBitMask = puckCategory
            puck.physicsBody?.collisionBitMask = paddleCategory | wallCategory | obstacleCategory // biar mantul dan gak tembus
            puck.physicsBody?.contactTestBitMask = goalCategory1 | goalCategory2 | paddleCategory | wallCategory | obstacleCategory  //contact //buat kasih logic codingan
            
            puck.physicsBody?.mass = 0.03
            puck.physicsBody?.affectedByGravity = false
            
        }
        
        puck.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if puck.parent == nil {
            addChild(puck)
        }
    }
    
    func createObstacle (){
        obstacle1 = SKSpriteNode(imageNamed: "1")
        obstacle2 = SKSpriteNode(imageNamed: "2")
        obstacle3 = SKSpriteNode(imageNamed: "3")
        
        obstacle1.size = CGSize(width: 245, height: 364)
        obstacle1.position = CGPoint(x: frame.midX , y: frame.midY - 100)
        obstacle1.physicsBody = SKPhysicsBody(texture: obstacle1.texture!, size: obstacle1.size)
        
        addChild(obstacle1)
        obstacle1.physicsBody?.isDynamic = false
        obstacle1.physicsBody?.categoryBitMask = obstacleCategory
        obstacle1.physicsBody?.collisionBitMask = puckCategory | paddleCategory // Puck will bounce off obstacle
        
        obstacle2.size = CGSize(width: 312.42, height: 328.36)
        obstacle2.position = CGPoint(x: frame.maxX - 200 , y: frame.minY + 110)
        obstacle2.physicsBody = SKPhysicsBody(texture: obstacle2.texture!, size: obstacle2.size)
        addChild(obstacle2)
        obstacle2.physicsBody?.isDynamic = false
        obstacle2.physicsBody?.categoryBitMask = obstacleCategory
        obstacle2.physicsBody?.collisionBitMask = puckCategory | paddleCategory // Puck will bounce off obstacle
        
        obstacle3.size = CGSize(width: 308, height: 313.66)
        obstacle3.position = CGPoint(x: frame.minX + 180 , y: frame.maxY - 130)
        obstacle3.physicsBody = SKPhysicsBody(texture: obstacle3.texture!, size: obstacle3.size)
        addChild(obstacle3)
        obstacle3.physicsBody?.isDynamic = false
        obstacle3.physicsBody?.categoryBitMask = obstacleCategory
        obstacle3.physicsBody?.collisionBitMask = puckCategory | paddleCategory // Puck will bounce off obstacle
        
        
    }

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        // Set up the game scene
        
        // Add background
        backgroundColor = .white
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        background.size = CGSize(width: 1412, height: 1000)
        background.alpha = 0.28
        addChild(background)
        
        createEdges()
        createObstacle()
        createGoalArea(at: CGPoint(x: frame.minX , y: frame.midY), area: 1)
        createGoalArea(at: CGPoint(x: frame.maxX , y: frame.midY), area: 2)
        createScoreLabels()
        createPaddle()
        createPuck()
        
        scene?.view?.isMultipleTouchEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) //
            
            if playerPaddle.contains(location) {
                playerTouch = touch
            }
            if opponentPaddle.contains(location) {
                opponentTouch = touch
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if touch == playerTouch {
                let limitedLocation = limitPositionToRect(location, rect: paddleLimitRect, isPlayerPaddle: true)
                //cek ada di posisitin gakkk
                if !obstacle1.contains(location) && !obstacle3.contains(location){
                    playerPaddle.position = limitedLocation
                }
            } else if touch == opponentTouch {
                let limitedLocation = limitPositionToRect(location, rect: paddleLimitRect, isPlayerPaddle: false)
//                opponentPaddle.position = limitedLocation
                if !obstacle1.contains(location) &&  !obstacle2.contains(location)  {
                    opponentPaddle.position = limitedLocation
                }
            }
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == playerTouch {
                playerTouch = nil
            } else if touch == opponentTouch {
                opponentTouch = nil
            }
        }
    }
    
    func limitPositionToRect(_ position: CGPoint, rect: CGRect, isPlayerPaddle: Bool) -> CGPoint {
        var limitedX: CGFloat
        if isPlayerPaddle {
            limitedX = max(rect.minX, min(position.x, rect.maxX + 40)) //nanti + 10 ajaa
        } else {
            limitedX = max(rect.maxX + 50, max(position.x, rect.maxX))
        }
        let limitedY = max(rect.minY, min(position.y, rect.maxY))
        return CGPoint(x: limitedX, y: limitedY)
    }
    
    func isOffScreen(node: SKSpriteNode) -> Bool {
        return !frame.contains(node.position)
    }
    
    func goalScored(by player: Int) {
        if player == 1 {
            playerScore += 1
            playerScoreLabel.text = "Player 1: \(playerScore)"
        } else if player == 2 {
            opponentScore += 1
            opponentScoreLabel.text = "Player 2: \(opponentScore)"
        }
        if playerScore == 7 || opponentScore == 7 { //harusnya 7
            print("stop")
            let winningScene = WinningScene(size: size)
            if playerScore == 7 {
                winningScene.winnerName = "Player 1"
            } else {
                winningScene.winnerName = "Player 2"
            }
            winningScene.scaleMode = scaleMode
            view?.presentScene(winningScene, transition: .fade(withDuration: 0.5))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if flag == 0 {
            createPuck()
            flag = 1
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyA.categoryBitMask)
        print(contact.bodyB.categoryBitMask)
        var playerWhoScored: Int?
        if contact.bodyA.categoryBitMask == goalCategory1 {
            playerWhoScored = 2
        }else if contact.bodyA.categoryBitMask == goalCategory2{
            playerWhoScored = 1
        }
        if let player = playerWhoScored {
            goalScored(by: player)
            flag = 0
        }
        
//        velocity, tau bolanya sama paddle
        if contact.bodyA.categoryBitMask == paddleCategory {
            let paddleNode: SKNode
            let paddleVelocity: CGVector
            paddleNode = contact.bodyB.node!
            paddleVelocity = paddleNode.physicsBody?.velocity ?? CGVector.zero
//            puck.physicsBody?.velocity = CGVector(dx: 750, dy: 1)
            puck.physicsBody?.velocity = paddleVelocity
            let impulseMagnitude: CGFloat = 10
            let impulse = CGVector(dx: impulseMagnitude * cos(contact.contactNormal.dx),
                                   dy: impulseMagnitude * cos(contact.contactNormal.dy))
            puck.physicsBody?.applyImpulse(impulse)
//
        }
        
    }
    
    func winShow(){
        WinningScene()
    }
    
    
}
