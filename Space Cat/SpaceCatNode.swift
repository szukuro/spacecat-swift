//
//  SpaceCatNode.swift
//  Space Cat
//
//  Created by László Györi on 04/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class SpaceCatNode: SKSpriteNode {
   
    var tapAction : SKAction?

    class func spaceCatAtPosition(position:CGPoint) -> SpaceCatNode {
        let spaceCat = SpaceCatNode(imageNamed: "spacecat_1")
        spaceCat.position = position
        spaceCat.anchorPoint = CGPointMake(0.5, 0)
        spaceCat.name = "SpaceCat"
        spaceCat.zPosition = 9
        
        return spaceCat
    }
    
    var getTapAction : SKAction! {
        if (!tapAction)
        {
            let texture1 = SKTexture(imageNamed:"spacecat_2")
            let texture2 = SKTexture(imageNamed:"spacecat_1")
            
            let textures : Array<SKTexture> = [ texture1, texture2 ]
            
            tapAction = SKAction.animateWithTextures(textures, timePerFrame:0.25)
        }
        return tapAction
    }
    
    func performTap() {
        self.runAction(self.getTapAction)
    }
}