//
//  SpaceDogNode.swift
//  Space Cat
//
//  Created by László Györi on 24/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

enum SpaceDogType : Int {
    case SpaceDogTypeA = 0
    case SpaceDogTypeB = 1
}

class SpaceDogNode: SKSpriteNode {
    
    var dogType : SpaceDogType?
    
    class func spaceDogOfType(type:SpaceDogType) -> SpaceDogNode {
        var spaceDog : SpaceDogNode
        var textures : Array<SKTexture>
        
        if ( type == SpaceDogType.SpaceDogTypeA) {
            spaceDog = SpaceDogNode(imageNamed: "spacedog_A_1")
            textures = [SKTexture(imageNamed: "spacedog_A_1"), SKTexture(imageNamed: "spacedog_A_2"), SKTexture(imageNamed: "spacedog_A_3")]
        } else if ( type == SpaceDogType.SpaceDogTypeB) {
            spaceDog = SpaceDogNode(imageNamed: "spacedog_B_1")
            textures = [SKTexture(imageNamed: "spacedog_B_1"), SKTexture(imageNamed: "spacedog_B_2"), SKTexture(imageNamed: "spacedog_B_3"), SKTexture(imageNamed: "spacedog_B_4")]
        } else {
            // need to be initialised no matter what
            spaceDog = SpaceDogNode()
            textures = []
        }
        
        spaceDog.dogType = type
        spaceDog.name = "SpaceDog"
        
        let scale = Util.random(85, max: 100)
        let scalef = CGFloat(scale) / 100.0

        spaceDog.xScale = scalef
        spaceDog.yScale = scalef
        
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        
        spaceDog.runAction(repeatAction)
        
        
        spaceDog.setupPhysicsBody()
        
        return spaceDog
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody!.affectedByGravity = false
        
        self.physicsBody!.categoryBitMask = CollisionCategory.CollisionCategoryEnemy.rawValue
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.contactTestBitMask = CollisionCategory.CollisionCategoryGround.rawValue
            | CollisionCategory.CollisionCategoryProjectile.rawValue
    }
}
