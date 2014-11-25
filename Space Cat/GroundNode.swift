//
//  GroundNode.swift
//  Space Cat
//
//  Created by László Györi on 24/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class GroundNode: SKSpriteNode {
 
    class func groundWithSize(size:CGSize) -> GroundNode {
        let ground = GroundNode(color: SKColor.clearColor(), size: size)
        ground.name = "Ground"
        ground.position = CGPointMake(size.width / 2, size.height / 2)
        ground.setupPhysicsBody()
        
        return ground
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.dynamic = false
        
        self.physicsBody!.categoryBitMask = CollisionCategory.CollisionCategoryGround.rawValue
        self.physicsBody!.collisionBitMask = CollisionCategory.CollisionCategoryDebris.rawValue
        self.physicsBody!.contactTestBitMask = CollisionCategory.CollisionCategoryEnemy.rawValue
    }
}
