//
//  HudNode.swift
//  Space Cat
//
//  Created by László Györi on 28/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class HudNode: SKNode {
    
    var lives : NSInteger = MaxLives
    var score : NSInteger = 0
}

extension HudNode {
    class func hudAtPosition(position:CGPoint, frame:CGRect) -> HudNode {
        let hud = HudNode()
        hud.position = position
        hud.zPosition = 10
        hud.name = "HUD"
        
        let catHead = SKSpriteNode(imageNamed: "HUD_cat_1")
        catHead.position = CGPointMake(30, -10)
        
        hud.addChild(catHead)
        
        var lastLifeBar : SKSpriteNode?
        
        for var i = 0; i < hud.lives; ++i {
           let lifeBar = SKSpriteNode(imageNamed: "HUD_life_1")
            lifeBar.name = "Life\(i + 1)"
            
            hud.addChild(lifeBar)
            
            if (lastLifeBar != nil) {
                lifeBar.position = CGPointMake(lastLifeBar!.position.x + 10, lastLifeBar!.position.y)
            }
            else {
                lifeBar.position = CGPointMake(catHead.position.x + 30, catHead.position.y)
            }
            
            lastLifeBar = lifeBar
        }
        
        let scoreLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        scoreLabel.name = "Score"
        scoreLabel.text = "\(hud.score)"
        scoreLabel.fontSize = 20
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.position = CGPointMake(frame.size.width - 20,
            -10)
        
        hud.addChild(scoreLabel)
        
        
        let muteButton = SKSpriteNode(imageNamed: "HUD_cat_1")
        muteButton.name = "Mute"
        muteButton.position = CGPointMake(frame.size.width - 25, frame.size.height * -1  + 45)
        
        hud.addChild(muteButton)
        
        return hud
    }
    
    func addPoints(points:Int) {
        self.score += points
        
        let scoreLabel = self.childNodeWithName("Score") as SKLabelNode
        scoreLabel.text = "\(self.score)"
    }
    
    func loseLife() -> Bool {
        if (self.lives > 0) {
            let lifeNodeName = "Life\(self.lives)"
            let lifeToRemove = self.childNodeWithName(lifeNodeName)
            lifeToRemove!.removeFromParent()
            self.lives--
        }
        
        return self.lives == 0
    }
}