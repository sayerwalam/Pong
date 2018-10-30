//
//  GameScene.swift
//  Pong
//
//  Created by Mohammed Sayerwala on 5/1/18.
//  Copyright © 2018 Mohammed Sayerwala. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var score = [Int]()
    var TopLabel = SKLabelNode()
    var BottomLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        startGame()
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        TopLabel = self.childNode(withName: "TopLabel") as! SKLabelNode
        BottomLabel = self.childNode(withName: "BottomLabel") as! SKLabelNode
        enemy.position.y = (self.frame.height / 2) - 50
        main.position.y = (-self.frame.height / 2) + 50
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        
        let myBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        myBorder.friction = 0
        myBorder.restitution = 1
        self.physicsBody = myBorder
        
    }
    
    func startGame(){
        score = [0,0]
        TopLabel.text = "\(score[1])"
        BottomLabel.text = "\(score[0])"
    }
    
    func addScore(playerWhoWon:SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
            
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        TopLabel.text = "\(score[1])"
        BottomLabel.text = "\(score[0])"
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            switch currentGameType {
            case .easy:
                    main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                    break
            case .medium:
                    main.run(SKAction.moveTo(x: location.x, duration: 0.25))
                    break
            case .hard:
                    main.run(SKAction.moveTo(x: location.x, duration: 0.4))
                    break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            switch currentGameType {
            case .easy:
                main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                break
            case .medium:
                main.run(SKAction.moveTo(x: location.x, duration: 0.25))
                break
            case .hard:
                main.run(SKAction.moveTo(x: location.x, duration: 0.4))
                break
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
       switch currentGameType
        {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.2))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        }
       
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}
