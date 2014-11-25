//
//  ProjectileNode.swift
//  Space Cat
//
//  Created by László Györi on 04/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class ProjectileNode: SKSpriteNode {
    
    class func projectileAtPosition(position:CGPoint) -> ProjectileNode {
        let projectile = ProjectileNode(imageNamed: "projectile_1")
        
        projectile.position = position
        projectile.name = "Projectile"

        projectile.setupAnimation()
        
        projectile.setupPhysicsBody()
        
        return projectile
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody!.affectedByGravity = false
        
        self.physicsBody!.categoryBitMask = CollisionCategory.CollisionCategoryProjectile.rawValue
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.contactTestBitMask = CollisionCategory.CollisionCategoryEnemy.rawValue
    }

    func setupAnimation() {
        let textures : Array<SKTexture> = [ SKTexture(imageNamed:"projectile_1"), SKTexture(imageNamed:"projectile_2"), SKTexture(imageNamed:"projectile_3") ]

        let animation = SKAction.animateWithTextures(textures, timePerFrame:0.1)
 
        let repeatAction = SKAction.repeatActionForever(animation)
        
        self.runAction(repeatAction)
       
    }
    
    func moveTowardsPosition(position : CGPoint) {
        let slope = (position.y - self.position.y) / (position.x - self.position.x)
        var offscreenX : CGFloat
        
        if (position.x <= self.position.x)
        {
            offscreenX = -10
        }
        else
        {
            offscreenX = self.parent!.frame.size.width + 10
        }
        
        let offscreenY = slope * offscreenX - slope * self.position.x + self.position.y
        
        let pointOffScreen = CGPointMake(offscreenX, offscreenY)
        
        let distanceA = pointOffScreen.y - self.position.y
        let distanceB = pointOffScreen.x - self.position.x
        
        let distanceC = sqrt(pow(distanceA, 2) + pow(distanceB, 2))
    
        let time = (distanceC / CGFloat(ProjectileSpeed))
        let waitToFade = time * 0.75
        let fadeTime = time - waitToFade
        
        let moveProjectile = SKAction.moveTo(pointOffScreen, duration: NSTimeInterval(time))
        self.runAction(moveProjectile)
        
        let sequence = [SKAction.waitForDuration(NSTimeInterval(waitToFade)),
                        SKAction.fadeOutWithDuration(NSTimeInterval(fadeTime)),
                            SKAction.removeFromParent()]
        self.runAction(SKAction.sequence(sequence))
    
    }
}
