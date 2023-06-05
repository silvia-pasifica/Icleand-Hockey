//
//  Paddle.swift
//  Iceland Hockey
//
//  Created by Silvia Pasica on 22/05/23.
//

import SpriteKit

class Paddle: SKScene, SKPhysicsContactDelegate{
    override func didMove(to view: SKView) {
        let puck = SKSpriteNode(imageNamed: "puck")
        puck.physicsBody = SKPhysicsBody(circleOfRadius: puck.size.width/2)

        //Creating a texture physisc body
        let obstacle = SKSpriteNode(imageNamed: "attribute1")
        obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!, size: obstacle.size)

        // Creating a polygon physics body
        let obstacle1 = SKSpriteNode(imageNamed: "attribute1")
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: -50, y: -50))
        polygonPath.addLine(to: CGPoint(x: 50, y: -50))
        polygonPath.addLine(to: CGPoint(x: 50, y: 50))
        polygonPath.addLine(to: CGPoint(x: -50, y: 50))
        polygonPath.close()

        obstacle1.physicsBody = SKPhysicsBody(polygonFrom: polygonPath.cgPath)

        // Creating a rectangular physics body
        let obstacle2 = SKSpriteNode(imageNamed: "attribute1")
        let rectangleSize = CGSize(width: 200, height: 200)
        obstacle2.physicsBody = SKPhysicsBody(rectangleOf: rectangleSize)

        // Creating a compound physics body with multiple shapes
        let obstacle3 = SKSpriteNode(imageNamed: "attribute2")
        let shape1 = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 200))
        let shape2 = SKPhysicsBody(circleOfRadius: 245/2)
        let compoundBody = SKPhysicsBody(bodies: [shape1, shape2])

        obstacle3.physicsBody = compoundBody
        
        puck.physicsBody?.isDynamic = false
        puck.size = CGSize(width: 200, height: 200)
        puck.position = CGPoint(x: frame.minX + 150 , y: frame.midY)
        puck.physicsBody?.affectedByGravity = false
        
        obstacle.physicsBody?.isDynamic = false
        obstacle.size = CGSize(width: 200, height: 200)
        obstacle.position = CGPoint(x: frame.minX + 400 , y: frame.midY)
        obstacle.physicsBody?.affectedByGravity = false
        
        obstacle1.physicsBody?.isDynamic = false
        obstacle1.size = CGSize(width: 200, height: 200)
        obstacle1.position = CGPoint(x: frame.minX + 650 , y: frame.midY)
        obstacle1.physicsBody?.affectedByGravity = false
        
        obstacle2.physicsBody?.isDynamic = false
        obstacle2.size = CGSize(width: 200, height: 200)
        obstacle2.position = CGPoint(x: frame.minX + 900 , y: frame.midY)
        obstacle2.physicsBody?.affectedByGravity = false
        
        obstacle3.physicsBody?.isDynamic = false
        obstacle3.size = CGSize(width: 200, height: 200)
        obstacle3.position = CGPoint(x: frame.minX + 1150 , y: frame.midY)
        obstacle3.physicsBody?.affectedByGravity = false
        
        addChild(puck)
        addChild(obstacle)
        addChild(obstacle1)
        addChild(obstacle2)
        addChild(obstacle3)
        
        // Create shape nodes to visualize the physics bodies
        let puckShape = SKShapeNode(circleOfRadius: puck.size.width/2)
        let obstacleShape = SKShapeNode(rectOf: obstacle.size)
        let obstacle1Shape = SKShapeNode(path: polygonPath.cgPath)
        let obstacle2Shape = SKShapeNode(rectOf: rectangleSize)
        let obstacle3Shape1 = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        let obstacle3Shape2 = SKShapeNode(circleOfRadius: 25)

        // Set the colors and properties of the shape nodes
        puckShape.strokeColor = .red
        obstacleShape.strokeColor = .green
        obstacle1Shape.strokeColor = .blue
        obstacle2Shape.strokeColor = .orange
        obstacle3Shape1.strokeColor = .purple
        obstacle3Shape2.strokeColor = .yellow

        // Add the shape nodes to the scene
        addChild(puckShape)
        addChild(obstacleShape)
        addChild(obstacle1Shape)
        addChild(obstacle2Shape)
        addChild(obstacle3Shape1)
        addChild(obstacle3Shape2)

        // Position the shape nodes to match the corresponding sprite nodes
        puckShape.position = puck.position
        obstacleShape.position = obstacle.position
        obstacle1Shape.position = obstacle1.position
        obstacle2Shape.position = obstacle2.position
        obstacle3Shape1.position = obstacle3.position
        obstacle3Shape2.position = obstacle3.position

        // Make the shape nodes non-dynamic and unaffected by gravity
        puckShape.physicsBody?.isDynamic = false
        obstacleShape.physicsBody?.isDynamic = false
        obstacle1Shape.physicsBody?.isDynamic = false
        obstacle2Shape.physicsBody?.isDynamic = false
        obstacle3Shape1.physicsBody?.isDynamic = false
        obstacle3Shape2.physicsBody?.isDynamic = false

        puckShape.physicsBody?.affectedByGravity = false
        obstacleShape.physicsBody?.affectedByGravity = false
        obstacle1Shape.physicsBody?.affectedByGravity = false
        obstacle2Shape.physicsBody?.affectedByGravity = false
        obstacle3Shape1.physicsBody?.affectedByGravity = false
        obstacle3Shape2.physicsBody?.affectedByGravity = false

    }
    
    
}
