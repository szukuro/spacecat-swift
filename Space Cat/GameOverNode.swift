//
//  GameOverNode.swift
//  Space Cat
//
//  Created by László Györi on 28/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverNode: SKNode {
   
    class func gameOverAtPosition(position:CGPoint) -> GameOverNode {
        let gameOver = GameOverNode()
        
        let gameOverLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        gameOverLabel.name = "GameOver"
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 48
        gameOverLabel.position = position
        
        gameOver.addChild(gameOverLabel)
        
        return gameOver
    }
    
    func performAnimation() {
        let label = self.childNodeWithName("GameOver") as SKLabelNode
        label.xScale = 0
        label.yScale = 0
        let scaleUp = SKAction.scaleTo(1.2, duration: 0.75)
        let scaleDown = SKAction.scaleTo(0.9, duration: 0.25)
        
        let run = SKAction.runBlock({
            let touchToRestart = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
            touchToRestart.text = "Touch To Restart"
            touchToRestart.fontSize = 24
            touchToRestart.position = CGPointMake(label.position.x, label.position.y - 40)
            self.addChild(touchToRestart)
            })
        
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown, run])
        label.runAction(scaleSequence)
    }
}
